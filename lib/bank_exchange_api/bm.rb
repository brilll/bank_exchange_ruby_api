module BankExchangeApi
  module Bm
    # @example
    #  Bm.measure(-> (ms) { puts ms }) do
    #   sleep(2)
    #  end
    def self.measure(cb)
      t1 = Time.now
      result = yield
      ms = (Time.now - t1).to_f * 1000

      cb.call(ms.round)

      result
    end
  end
end
