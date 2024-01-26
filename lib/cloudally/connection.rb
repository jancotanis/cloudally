require 'faraday'
#require 'faraday_middleware'
#Dir[File.expand_path('../../faraday/*.rb', __FILE__)].each{|f| require f}

module CloudAlly
	# @private
	module Connection
	private

		def connection
		  options = {
			:headers => { 
				'Accept' => "application/#{format}; charset=utf-8",
				'User-Agent' => user_agent
			},
			:url => endpoint
		  }.merge( connection_options )

		  Faraday::Connection.new(options) do |connection|
			connection.use Faraday::Response::RaiseError
			#connection.use FaradayMiddleware::RaiseHttpException
			connection.adapter Faraday.default_adapter

			#connection.use FaradayMiddleware::InstagramOAuth2, client_id, access_token
			connection.authorization :Bearer, access_token if access_token
			connection.headers['client-id'] = client_id
			connection.headers['client-secret'] = client_secret
			connection.response :json, :content_type => /\bjson$/
			connection.use Faraday::Request::UrlEncoded

			#connection.use FaradayMiddleware::LoudLogger if loud_logger
			if logger
				connection.response :logger, logger, { headers: true, bodies: true } do |l|
					# filter json content
					l.filter(/(\"password\"\:\")(.+?)(\".*)/, '\1[REMOVED]\3')
					l.filter(/(\"accessToken\"\:\")(.+?)(\".*)/, '\1[REMOVED]\3')
					# filter header content
					l.filter(/(client-secret\:.)([^&]+)/, '\1[REMOVED]')
					l.filter(/(Authorization\:.)([^&]+)/, '\1[REMOVED]')
				end
			end
		  end
		end
	end
end
