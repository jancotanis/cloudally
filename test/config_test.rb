require "test_helper"

describe 'config' do
  it "#1 defaults" do
    CloudAlly.reset
    assert value(CloudAlly.endpoint).must_equal CloudAlly::Configuration::DEFAULT_ENDPOINT, ".endpoint"
    assert value(CloudAlly.format).must_equal CloudAlly::Configuration::DEFAULT_FORMAT, ".format"
    assert value(CloudAlly.user_agent).must_equal CloudAlly::Configuration::DEFAULT_USER_AGENT, ".user_agent"
    assert CloudAlly.logger.nil?, ".logger"
  end
  it "#2 configure block" do
    CloudAlly.configure do |config|
      config.access_token = "YOUR_ACCESS_TOKEN"
      config.client_id = "YOUR_CLIENT_ID"
      config.client_secret = "YOUR_CLIENT_SECRET"
      config.endpoint = 'http://api.abc.com'
      config.format = 'xml'
      config.user_agent = 'Custom User Agent'
      config.logger = true
    end
    assert value(CloudAlly.access_token).must_equal "YOUR_ACCESS_TOKEN", ".access_token="
    assert value(CloudAlly.client_id).must_equal "YOUR_CLIENT_ID", ".client_id="
    assert value(CloudAlly.client_secret).must_equal "YOUR_CLIENT_SECRET", ".client_secret="
    assert value(CloudAlly.endpoint).must_equal "http://api.abc.com", ".format="
    assert value(CloudAlly.format).must_equal "xml", ".format="
    assert value(CloudAlly.user_agent).must_equal 'Custom User Agent', ".user_agent="
    assert value(CloudAlly.logger).must_equal true, ".logger="
  end
  it "#3 configure all" do
    CloudAlly::Configuration::VALID_OPTIONS_KEYS.each do |key|
      CloudAlly.configure do |config|
        config.send("#{key}=", key)
        assert value(CloudAlly.send(key)).must_equal key, ".{key}=key"
      end
    end
  end
  it "#4 client hash" do
    options = {
      access_token: "YOUR_ACCESS_TOKEN",
      client_id: "YOUR_CLIENT_ID",
      client_secret: "YOUR_CLIENT_SECRET",
      endpoint: 'http://coas.com',
      format: 'xml',
      user_agent: 'Custom User Agent',
      logger: true
    }
    c = CloudAlly::Client.new(options)
    assert value(c.access_token).must_equal "YOUR_ACCESS_TOKEN", ".access_token="
    assert value(c.client_id).must_equal "YOUR_CLIENT_ID", ".client_id="
    assert value(c.client_secret).must_equal "YOUR_CLIENT_SECRET", ".client_secret="
    assert value(c.format).must_equal "xml", ".format="
    assert value(c.user_agent).must_equal 'Custom User Agent', ".user_agent="
    assert value(c.logger).must_equal true, ".logger="
  end
end
