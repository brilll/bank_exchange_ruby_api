module BankExchangeApi::Request
  class Banks < Base
    param :countries, :currencies, Array

    def json
      super(root: :banks)
    end

    def params
      {
          countries: countries.join(','),
          currencies: currencies.join(',')
      }
    end

    def endpoint
      '/banks'
    end
  end
end
