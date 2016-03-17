module BankExchangeApi
  # Generic exception class
  class Error < StandardError
  end

  # Raised when config is being configured improperly
  # or configuration param is invalid
  class ConfigurationError < Error
  end
end
