require 'faraday'

module CloudAlly
  # @private
  module Connection
    private

    def connection
      options = {
        headers: {
          'Accept': "application/#{format}; charset=utf-8",
          'User-Agent': user_agent
        },
        url: endpoint
      }.merge(connection_options)

      Faraday::Connection.new(options) do |connection|
        connection.use Faraday::Response::RaiseError
        connection.adapter Faraday.default_adapter

        connection.authorization :Bearer, access_token if access_token
        connection.headers['client-id'] = client_id
        connection.headers['client-secret'] = client_secret
        connection.response :json, content_type: /\bjson$/
        connection.use Faraday::Request::UrlEncoded

        setup_logger_filtering(connection,logger) if logger
      end
    end

    def setup_logger_filtering(connection,logger)
      connection.response :logger, logger, { headers: true, bodies: true } do |l|
        # filter json content
        l.filter(/("password":")(.+?)(".*)/, '\1[REMOVED]\3')
        l.filter(/("accessToken":")(.+?)(".*)/, '\1[REMOVED]\3')
        # filter header content
        l.filter(/(client-secret\:.)([^&]+)/, '\1[REMOVED]')
        l.filter(/(Authorization\:.)([^&]+)/, '\1[REMOVED]')
      end
    end
  end
end
