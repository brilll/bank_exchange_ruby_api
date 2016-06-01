module BankExchangeApi::Response
  class Base
    attr_reader :http, :root

    def initialize(http, root: nil)
      @http = http
      @root = root
    end

    def success?
      http.code.to_i == 200
    end

    # Response payload data
    # @example
    #   rates: [{currency: 'EUR'}, {currency: 'EUR'}]
    # User *root* param to access the data
    def data
      raise NotImplementedError, __method__
    end

    # Request params in responce
    # @example
    #   params: {currencies: 'EUR,USD'}
    def params
      raise NotImplementedError, __method__
    end

    # Response body
    # @example
    #   params: {}, rates: []
    def body
      raise NotImplementedError, __method__
    end

    def pagination
      raise NotImplementedError, __method__
    end

    def next_page_url
      raise NotImplementedError, __method__
    end

    def paginatable?
      !next_page_url.nil?
    end

    def not_paginatable?
      !paginatable?
    end
  end
end
