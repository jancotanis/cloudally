# frozen_string_literal: true

module CloudAlly
  # Generic error to be able to rescue all CloudAlly errors
  class CloudAllyError < StandardError; end

  # Error when configuration not sufficient
  class ConfigurationError < CloudAllyError; end

  # Error when authentication fails
  class AuthenticationError < CloudAllyError; end
end
