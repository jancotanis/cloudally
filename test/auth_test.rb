require 'minitest/autorun'
require 'minitest/spec'
require 'Dotenv'
require 'logger'
require "test_helper"

AUTH_LOGGER = "auth_test.log"
File.delete(AUTH_LOGGER) if File.exist?(AUTH_LOGGER)

describe 'auth' do
  before do
    Dotenv.load
    CloudAlly.reset
  end
  it "#1 not logged in" do
    c = CloudAlly::Client.new({ logger: Logger.new(AUTH_LOGGER) })
    assert_raises Faraday::BadRequestError do
      c.partner_login
    end
  end
  it "#2 logged in" do
    CloudAlly.configure do |config|
      config.client_id = ENV["CLOUDALLY_CLIENT_ID"]
      config.client_secret = ENV["CLOUDALLY_CLIENT_SECRET"]
      config.username = ENV["CLOUDALLY_USER"]
      config.password = ENV["CLOUDALLY_PASSWORD"]
    end
    c = CloudAlly::Client.new()
    refute_empty c.partner_login, ".partner_login"
  end
  it "#3 wrong credentials" do
    CloudAlly.configure do |config|
      config.client_id = ENV["CLOUDALLY_CLIENT_ID"]
      config.client_secret = ENV["CLOUDALLY_CLIENT_SECRET"]
      config.username = "john"
      config.password = "doe"
    end
    c = CloudAlly::Client.new()
    assert_raises Exception do
      c.partner_login
    end
    c = CloudAlly::Client.new()
    assert_raises Exception do
      c.login
    end
  end
end
