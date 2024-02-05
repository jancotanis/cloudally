
module CloudAlly
  # Deals with authentication flow and stores it within global configuration
  module Authentication
    # Authorize to the CloudAlly portal and return access_token
    def auth(options = {})
      api_auth('/auth', options)
    end
    alias login auth

    # Return an access token from authorization
    def auth_refresh(token)
      api_refresh('/auth/refresh', token)
    end

    # Authorize to the partner portal and return access_token
    def auth_partner(options = {})
      api_auth('/auth/partner', options)
    end
    alias partner_login auth_partner
  private
    def api_access_token_params
      {
        email: username,
        password: password
      }
    end
  end
end
