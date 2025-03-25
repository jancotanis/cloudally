# frozen_string_literal: true

module CloudAlly
  # Wrapper for the CloudAlly REST API
  #
  # @note All methods have been separated into modules and follow the same grouping used in api docs
  # @see https://api.cloudally.com/documentation
  class Client < API
    Dir[File.expand_path('client/*.rb', __dir__)].each { |lib| require lib }

    include CloudAlly::Client::PartnerPortal
  end
end
