# frozen_string_literal: true

require 'wrapi'

require File.expand_path('cloudally/api', __dir__)
require File.expand_path('cloudally/client', __dir__)
require File.expand_path('cloudally/version', __dir__)
require File.expand_path('cloudally/pagination', __dir__)

##
# This module is a wrapper for the CloudAlly API, using the WrAPI framework.
module CloudAlly
  extend WrAPI::Configuration
  extend WrAPI::RespondTo

  # Default API endpoint for CloudAlly
  DEFAULT_ENDPOINT  = 'https://api.cloudally.com/v1/'

  # Default User-Agent string used in requests
  DEFAULT_USERAGENT = "CloudAlly Ruby API wrapper #{CloudAlly::VERSION}"

  # Default pagination strategy
  DEFAULT_PAGINATION = CloudAlly::RequestPagination::Pager

  ##
  # Creates and returns a new instance of `CloudAlly::Client` with default settings.
  #
  # @param options [Hash] Additional options to override defaults.
  # @option options [String] :endpoint Custom API endpoint.
  # @option options [String] :user_agent Custom User-Agent header.
  # @option options [Class] :pagination_class Custom pagination class.
  #
  # @return [CloudAlly::Client] A new API client instance.
  def self.client(options = {})
    CloudAlly::Client.new({
      endpoint: DEFAULT_ENDPOINT,
      user_agent: DEFAULT_USERAGENT,
      pagination_class: DEFAULT_PAGINATION
    }.merge(options))
  end

  ##
  # Resets CloudAlly API configuration to default values.
  def self.reset
    super
    self.endpoint = DEFAULT_ENDPOINT
    self.user_agent = DEFAULT_USERAGENT
    self.pagination_class = DEFAULT_PAGINATION
  end
end
