module BankExchangeApi
  # Generic exception class
  class Error < StandardError
  end

  # Raise when config is being configured improperly
  # or configuration param is invalid
  class ConfigurationError < Error
  end

  # Raise when class passed into a Param accessor is unsupported
  class UnsupportedParamClass < Error
  end

  class MissingRequiredParam < Error
  end
end
