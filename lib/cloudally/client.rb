module CloudAlly
  # Wrapper for the CloudAlly REST API
  #
  # @note All methods have been separated into modules and follow the same grouping used in api docs
  # @see https://api.cloudally.com/documentation
  class Client < API
    Dir[File.expand_path('../client/*.rb', __FILE__)].each{|f| require f}

    include CloudAlly::Client::PartnerPortal
  end
end
