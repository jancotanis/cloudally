require_relative "./version"
module CloudAlly
  # Defines constants and methods related to configuration
  module Configuration
    # An array of valid keys in the options hash when configuring a {CloudAlly::API}

    VALID_OPTIONS_KEYS = [
      :access_token,
      :token_type,
      :refresh_token,
      :token_expires,
      :client_id,
      :client_secret,
      :connection_options,
      :username,
      :password,
      :endpoint,
      :logger,
      :format,
      :page_size,
      :user_agent
    ].freeze


    # By default, don't set any connection options
    DEFAULT_CONNECTION_OPTIONS = {}

    # The endpoint that will be used to connect if none is set
    #
    # @note There is no reason to use any other endpoint at this time
    DEFAULT_ENDPOINT = "https://api.cloudally.com/v1/".freeze

    # The response format appended to the path and sent in the 'Accept' header if none is set
    #
    # @note JSON is the only available format at this time
    DEFAULT_FORMAT = :json

    # The page size for paged rest responses
    #
    # @note default JSON is the only available format at this time
    DEFAULT_PAGE_SIZE = 500

    # The user agent that will be sent to the API endpoint if none is set
    DEFAULT_USER_AGENT = "CloudAlly Ruby API wrapper #{CloudAlly::VERSION}".freeze

    # @private
    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # Reset all configuration options to defaults
    def reset
      self.access_token       = nil
      self.token_type         = nil
      self.refresh_token      = nil
      self.token_expires      = nil
      self.client_id          = nil
      self.client_secret      = nil
      self.username           = nil
      self.password           = nil

      self.logger             = DEFAULT_LOGGER

      self.connection_options = DEFAULT_CONNECTION_OPTIONS
      self.endpoint           = DEFAULT_ENDPOINT
      self.format             = DEFAULT_FORMAT
      self.page_size          = DEFAULT_PAGE_SIZE
      self.user_agent         = DEFAULT_USER_AGENT

    end
  end
end
