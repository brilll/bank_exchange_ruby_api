module BankExchangeApi
  module Request
    autoload :Base  , 'bank_exchange_api/request/base'
    autoload :Ping  , 'bank_exchange_api/request/ping'
    autoload :Banks , 'bank_exchange_api/request/banks'
    autoload :Bank  , 'bank_exchange_api/request/bank'
  end
end
