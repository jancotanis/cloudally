require 'uri'
require 'json'

module CloudAlly
  # Defines HTTP request methods
  # required attributes format
  module RequestPagination

    class Pager
      def initialize(page_size)
        @page = 1
        @page_size = page_size
        @total = @page + 1
        @next_page = ''
      end
      def page_options
        following_page = { pageSize: @page_size }
        unless @next_page.empty?
          following_page.merge!({ page: @page, nextPageToken: @next_page }) 
        else
          following_page
        end
      end
      def next_page!(data)
        @page += 1
        @total = data['totalPages'].to_i
        @next_page = data['nextPageToken']
      end
      def self.data(body) 
        body['data'] ? body['data'] : body
      end
      def more_pages?
        @page < @total
      end
    end
  end
end
