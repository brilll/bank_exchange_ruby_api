require 'forwardable'
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

    def pagination
      body.fetch('pagination', {})
    end

    def next_page_url
      pagination['next_page_url']
    end

    def data
      root ? body[root.to_s] : body
    end

    def inspect
      body
    end
  end
end
