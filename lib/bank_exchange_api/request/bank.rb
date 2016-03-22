module BankExchangeApi::Request
  class Bank < Base
    param :swift, String
    param :currencies, Array
    param :date, Date
    param :fallback_days, Integer

    def json
      super(root: :rates)
    end

    def params
      {
          currencies: currencies.join(','),
          date: date,
          fallback_days: fallback_days,
      }
    end

    def endpoint
      "/banks/#{swift!}"
    end
  end
end
