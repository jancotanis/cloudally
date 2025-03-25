# frozen_string_literal: true

require 'test_helper'

describe 'config' do
  it '#1 defaults' do
    CloudAlly.reset
    assert value(CloudAlly.endpoint).must_equal 'https://api.cloudally.com/v1/', ".endpoint"
    assert value(CloudAlly.format).must_equal :json, '.format'
    assert value(CloudAlly.user_agent).must_equal "CloudAlly Ruby API wrapper #{CloudAlly::VERSION}", '.user_agent'
    assert CloudAlly.logger.nil?, ".logger"
  end
  it "#2 configure block" do
    CloudAlly.configure do |config|
      config.access_token = 'YOUR_ACCESS_TOKEN'
      config.client_id = 'YOUR_CLIENT_ID'
      config.client_secret = 'YOUR_CLIENT_SECRET'
      config.endpoint = 'http://api.abc.com'
      config.format = 'xml'
      config.user_agent = 'Custom User Agent'
      config.logger = true
    end
    assert value(CloudAlly.access_token).must_equal 'YOUR_ACCESS_TOKEN', '.access_token='
    assert value(CloudAlly.client_id).must_equal 'YOUR_CLIENT_ID', '.client_id='
    assert value(CloudAlly.client_secret).must_equal 'YOUR_CLIENT_SECRET', '.client_secret='
    assert value(CloudAlly.endpoint).must_equal 'http://api.abc.com', '.format='
    assert value(CloudAlly.format).must_equal 'xml', '.format='
    assert value(CloudAlly.user_agent).must_equal 'Custom User Agent', '.user_agent='
    assert value(CloudAlly.logger).must_equal true, '.logger='
  end
  it '#4 client hash' do
    options = {
      access_token: 'YOUR_ACCESS_TOKEN',
      client_id: 'YOUR_CLIENT_ID',
      client_secret: 'YOUR_CLIENT_SECRET',
      format: 'xml',
      user_agent: 'Custom User Agent',
      logger: true
    }
    c = CloudAlly.client(options)
    assert value(c.access_token).must_equal 'YOUR_ACCESS_TOKEN', '.access_token='
    assert value(c.client_id).must_equal 'YOUR_CLIENT_ID', '.client_id='
    assert value(c.client_secret).must_equal 'YOUR_CLIENT_SECRET', '.client_secret='
    assert value(c.format).must_equal 'xml', '.format='
    assert value(c.user_agent).must_equal 'Custom User Agent', '.user_agent='
    assert value(c.logger).must_equal true, '.logger='
  end
end
