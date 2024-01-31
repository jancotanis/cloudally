require 'uri'
require 'json'

module CloudAlly
  # Defines HTTP request methods
  module Request
    class Entity
      attr_reader :attributes

      def initialize attributes
        @_raw = attributes
        @attributes = attributes.clone.transform_keys(&:to_s)
      end

      def method_missing(method_sym, *arguments, &block)
        len = arguments.length
        if method = method_sym[/.*(?==\z)/m]
          # assignment
          if len != 1
            raise! ArgumentError, "wrong number of arguments (given #{len}, expected 1)", caller(1)
          end
          @attributes[method] = arguments[0]
        elsif @attributes.include? method_sym.to_s
          r = @attributes[method_sym.to_s]
          case r
          when Hash
            r = @attributes[method_sym.to_s] = self.class.new(r)
          when Array
            # make deep copy
            @attributes[method_sym.to_s] = r = r.map { |item|
              self.class.new(item)
            } if r.length > 0 && r[0].is_a?(Hash)
            r
          else
            r
          end
        else
          super
        end
      end

      def respond_to?(method_sym, include_private = false)
        if @attributes.include? method_sym.to_s
          true
        else
          super
        end
      end

      def to_json options={}
        @_raw.to_json
      end
    end

    # Perform an HTTP GET request and return entity
    def get(path, options = {})
      response = request(:get, path, options)
      :json.eql?(format) ? Entity.new(response.body) : response.body
    end

    # Perform an HTTP GET request for paged date sets responsind to
    # Name			Description
    # pageSize		The number of records to display per page
    # page			The page number
    # nextPageToken Next page token
    def get_paged(path, options = {}, &block)
      raise! ArgumentError,
             "Pages requests should be json formatted (given format '#{format}')" unless :json.eql? format
      result = []
      page = 1
      total = page + 1
      nextPage = ""
      while page <= total
        # https://api.cloudally.com/v3/api-docs/v1
        followingPage = { pageSize: page_size }
        followingPage.merge!({ page: page, nextPageToken: nextPage }) unless nextPage.empty?

        response = request(:get, path, options.merge(followingPage))
        data = response.body
        d = data["data"].map { |e| Entity.new(e) }
        if block_given?
          yield(d)
        else
          result += d
        end
        page += 1
        total = data["totalPages"].to_i
        nextPage = data["nextPageToken"]
      end
      result unless block_given?
    end

    # Perform an HTTP POST request
    def post(path, options = {})
      request(:post, path, options)
    end

    # Perform an HTTP PUT request
    def put(path, options = {})
      request(:put, path, options)
    end

    # Perform an HTTP DELETE request
    def delete(path, options = {})
      request(:delete, path, options)
    end

    private

    # Perform an HTTP request
    def request(method, path, options)
      response = connection().send(method) do |request|
        uri = URI::Parser.new
        case method
        when :get, :delete
          request.url(uri.escape(path), options)
        when :post, :put
          request.headers['Content-Type'] = "application/#{format}"
          request.path = uri.escape(path)
          request.body = options.to_json unless options.empty?
        end
      end
      response
    end
  end
end
