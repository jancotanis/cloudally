# frozen_string_literal: true

require 'uri'
require 'json'

module CloudAlly
  # Provides functionality for handling paginated API requests.
  #
  # The `RequestPagination` module defines a `Pager` class, which is used to manage pagination 
  # for API responses that return multiple pages of data.
  #
  module RequestPagination
    # The `Pager` class helps navigate paginated API responses.
    #
    # It tracks the current page, total pages, and next page token for seamless pagination.
    #
    # @example Using the Pager class:
    #   pager = CloudAlly::RequestPagination::Pager.new(50)
    #   options = pager.page_options
    #   response = api_call(options)
    #   pager.next_page!(response.body) if pager.more_pages?
    #
    class Pager
      # Initializes a new Pager instance.
      #
      # @param page_size [Integer] The number of records per page.
      def initialize(page_size)
        @page = 1
        @page_size = page_size
        @total = @page + 1
        @next_page = ''
      end

      # Returns the options needed for fetching the next page of data.
      #
      # @return [Hash] The pagination parameters, including `pageSize`, `page`, and `nextPageToken` (if available).
      def page_options
        following_page = { pageSize: @page_size }
        unless @next_page.empty?
          following_page.merge!({ page: @page, nextPageToken: @next_page }) 
        else
          following_page
        end
      end

      # Updates the pagination state based on the API response.
      #
      # @param data [Hash] The response body containing pagination details.
      def next_page!(data)
        @page += 1
        @total = data['totalPages'].to_i
        @next_page = data['nextPageToken']
      end

      # Extracts the data portion of the API response.
      #
      # @param body [Hash] The API response body.
      # @return [Hash, Array] The extracted data portion.
      def self.data(body) 
        body['data'] || body
      end

      # Checks if there are more pages to retrieve.
      #
      # @return [Boolean] `true` if more pages are available, `false` otherwise.
      def more_pages?
        @page < @total
      end
    end
  end
end
