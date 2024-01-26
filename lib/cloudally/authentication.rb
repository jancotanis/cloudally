module CloudAlly
	# Defines HTTP request methods
	module Authentication

		# Return an access token from authorization
		def get_access_token(options={})
			params = access_token_params.merge(options)

			response = post("/auth/partner", params)
			res = JSON.parse( response.body )

			access_token = res[ "accessToken" ]

			raise Exception.new 'Could not find valid accessToken' if access_token == '' || access_token.nil?
			access_token
		end

		# Authorize to the CloudAlly portal and return access_token
		def auth( options={} )
			params = access_token_params.merge(options)
			response = post("/auth", params)
			# return access_token
			process_token( response.body )
		end
		alias login auth

		# Return an access token from authorization
		def auth_refresh( token )
			params = { refreshToken: token}

			response = post( "/auth/refresh", params )
			# return access_token
			process_token( response.body )
		end

		# Authorize to the partner portal and return access_token
		def auth_partner( options={} )
			params = access_token_params.merge(options)
			response = post("/auth/partner", params)
			# return access_token
			process_token( response.body )
		end
		alias partner_login auth_partner

		private

		def access_token_params
			{
			  email: username,
			  password: password
			}
		end
		def process_token( response )
			at = nil
			CloudAlly.configure do |config|
				at = config.access_token	= response[ "accessToken" ]
				config.token_type			= response[ "tokenType" ]
				config.refresh_token		= response[ "refreshToken" ]
				config.token_expires		= response[ "expiresIn" ]
			end
			raise Exception.new 'Could not find valid accessToken; response '+response.to_s if at == '' || at.nil?
			at
		end
	end
end
