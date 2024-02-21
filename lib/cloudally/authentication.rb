require 'faraday'
require File.expand_path('error', __dir__)

module CloudAlly
  # Deals with authentication flow and stores it within global configuration
  module Authentication
    # Authorize to the CloudAlly portal and return access_token
    def auth(options = {})
      raise raise ConfigurationError.new "client_id and/or client_secret empty" unless client_id && client_secret
      api_auth('/auth', options)
    rescue Faraday::UnauthorizedError => e
      raise AuthenticationError.new e.to_s
    end
    alias login auth

    # Return an access token from authorization
    def auth_refresh(token)
      api_refresh('/auth/refresh', token)
    rescue Faraday::UnauthorizedError => e
      raise AuthenticationError.new e.to_s
    end

    # Authorize to the partner portal and return access_token
    def auth_partner(options = {})
      raise raise ConfigurationError.new "client_id and/or client_secret empty" unless client_id && client_secret
      api_auth('/auth/partner', options)
    rescue Faraday::ServerError, Faraday::UnauthorizedError => e
      raise AuthenticationError.new e.to_s
    end
    alias partner_login auth_partner
  private
    def api_access_token_params
      raise raise ConfigurationError.new "username and/or password empty" unless username && password
      {
        email: username,
        password: password
      }
    end
  end
end
