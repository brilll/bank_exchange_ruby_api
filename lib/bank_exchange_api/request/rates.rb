module BankExchangeApi::Request
  class Rates < Base
    param :swift, :iso_from, :iso_to, Array
    param :date, Date
    param :fallback_days, Integer

    def json
      super(root: :rates)
    end

    def params
      {
          date: date,
          swift: swift.join(','),
          iso_from: iso_from.join(','),
          iso_to: iso_to.join(','),
          fallback_days: fallback_days
      }
    end

    def endpoint
      '/rates'
    end
  end
end
