module BankExchangeApi::Request
  class Bank < Base
    param :swift, String
    param :iso_to, Array
    param :date, Date
    param :fallback_days, Integer

    def json
      super(root: :rates)
    end

    def params
      {
          iso_to: iso_to.join(','),
          date: date,
          fallback_days: fallback_days,
      }
    end

    def endpoint
      "/banks/#{swift!}"
    end
  end
end
