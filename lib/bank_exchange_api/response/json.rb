require 'json'

module BankExchangeApi::Response
  class Json < Base

    extend Forwardable

    def_delegators :data, :each

    def body
      @body ||= JSON.parse(http.body)
    end

    def params
      body.fetch('params', {})
    end

    def data
      root ? body[root.to_s] : body
    end

    def inspect
      data
    end
  end
end
