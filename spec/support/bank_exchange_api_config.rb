require 'logger'

BankExchangeApi::Config.api_token = ENV.fetch('BANK_EXCHANGE_API_TOKEN', 'bank_exchange_api_token') # for the CI
BankExchangeApi::Config.logger = Logger.new(File.join($ROOT_PATH, 'log', 'test.log'))
