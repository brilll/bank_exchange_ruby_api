# Core
require 'bank_exchange_api/version'
require 'bank_exchange_api/errors'
require 'bank_exchange_api/config'
require 'bank_exchange_api/connection'
require 'bank_exchange_api/bm'

module BankExchangeApi
  class Cli
    # @param config_params [Hash]
    def initialize(config_params={})
      config_params.each{ |key, value| config.public_send("#{key}=", value) }
    end

    def config
      @config ||= Config.new
    end

    def logger
      @logger ||= config.logger
    end

    def connection
      @connection ||= Connection.new(self)
    end

    def info(value)
      logger && logger.info(value)
    end
  end
end
