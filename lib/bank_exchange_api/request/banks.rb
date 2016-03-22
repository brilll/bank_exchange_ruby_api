module BankExchangeApi::Request
  class Banks < Base
    def json
      super(root: :banks)
    end

    def path
      '/banks'
    end
  end
end
