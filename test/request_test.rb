require 'Dotenv'
require 'logger'
require 'test_helper'

REQUEST_LOGGER = 'request_test.log'
File.delete(REQUEST_LOGGER) if File.exist?(REQUEST_LOGGER)

describe 'client' do
  before do
    Dotenv.load
    CloudAlly.configure do |config|
      config.client_id = ENV["CLOUDALLY_CLIENT_ID"]
      config.client_secret = ENV["CLOUDALLY_CLIENT_SECRET"]
      config.username = ENV["CLOUDALLY_USER"]
      config.password = ENV["CLOUDALLY_PASSWORD"]
      config.logger = Logger.new(REQUEST_LOGGER)
    end
    CloudAlly.partner_login
    @client = CloudAlly.client
  end

  it "#1 GET paging/count" do
    # get response and check total records
    url = 'partners/status'
    result = @client.get(url,{"pageSize":CloudAlly.page_size})
    status = @client.partner_status

    assert value(status.count).must_equal result.total , "number of records"
    pages = 0
    @client.get_paged(url) do |batch|
      pages += 1
    end
    assert value(pages).must_equal result.totalPages, "number of batches"
  end
end
