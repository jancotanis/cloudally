require "wrapi"

require File.expand_path('cloudally/api', __dir__)
require File.expand_path('cloudally/client', __dir__)
require File.expand_path('cloudally/version', __dir__)

module CloudAlly
  extend WrAPI::Configuration
  extend WrAPI::RespondTo

  DEFAULT_ENDPOINT  = 'https://api.cloudally.com/v1/'.freeze
  DEFAULT_USERAGENT = "CloudAlly Ruby API wrapper #{CloudAlly::VERSION}".freeze

  # Alias for CloudAlly::Client.new
  #
  # @return [CloudAlly::Client]
  def self.client(options = {})
    CloudAlly::Client.new({
      endpoint: DEFAULT_ENDPOINT,
      user_agent: DEFAULT_USERAGENT
    }.merge(options))
  end
  
  def self.reset
    super
    self.endpoint = DEFAULT_ENDPOINT
    self.user_agent = DEFAULT_USERAGENT
  end
end
