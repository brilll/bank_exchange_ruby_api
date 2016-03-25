module BankExchangeApi::Request
  class Rate < Base
    param :iso_code, String
    param :iso_from, :iso_to, Array
    param :date, Date
    param :fallback_days, Integer

    def json
      super(root: :rates)
    end

    def params
      {
          date: date,
          iso_from: iso_from.join(','),
          iso_to: iso_to.join(','),
          fallback_days: fallback_days
      }
    end

    def endpoint
      "/rates/#{iso_code!}"
    end
  end
end
