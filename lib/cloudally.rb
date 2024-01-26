require File.expand_path('../cloudally/configuration', __FILE__)
require File.expand_path('../cloudally/api', __FILE__)
require File.expand_path('../cloudally/client', __FILE__)
require File.expand_path('../cloudally/version', __FILE__)

module CloudAlly
	extend Configuration

	# Alias for CloudAlly::Client.new
	#
	# @return [CloudAlly::Client]
	def self.client(options={})
		CloudAlly::Client.new(options)
	end

	# Delegate to CloudAlly::Client
	def self.method_missing(method, *args, &block)
		return super unless client.respond_to?(method)
		client.send(method, *args, &block)
	end

	# Delegate to CloudAlly::Client
	def self.respond_to?(method, include_all=false)
		return client.respond_to?(method, include_all) || super
	end
end
