# frozen_string_literal: true

require 'wrapi'
require File.expand_path('authentication', __dir__)

module CloudAlly
  class API
    attr_accessor *WrAPI::Configuration::VALID_OPTIONS_KEYS

    # Creates a new API
    def initialize(options = {})
      options = CloudAlly.options.merge(options)
      WrAPI::Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    def config
      conf = {}
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        conf[key] = send key
      end
      conf
    end

    include WrAPI::Connection
    include WrAPI::Request
    include WrAPI::Authentication
    include Authentication
  end
end
