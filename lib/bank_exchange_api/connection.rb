module BankExchangeApi
  class Connection

    HOST = 'api.bank.exchange'.freeze
    PORT = 80.freeze

    attr_reader :cli

    def initialize(cli)
      @cli = cli
    end

    def transport
      @transport ||= Net::HTTP.new(HOST, PORT)
    end

    def headers
      {
          'Accept' => 'application/json',
          'X-Api-Token' => cli.config.api_token!,
          'X-Client' => 'bank_exchange_ruby_api',
          'X-Client-Version' => VERSION
      }
    end

    def get(uri)
      bm :GET, uri do
        transport.get(uri, headers)
      end
    end

    private

    def bm(prefix, message, &block)
      cb = -> (ms) { cli.info("[#{prefix} #{ms}ms.] #{message}") }
      Bm.measure(cb, &block)
    end
  end
end
