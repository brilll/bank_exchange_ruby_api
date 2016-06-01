require 'net/http'

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
        transport.get(uri, headers).tap do |http|
          error(uri, http) unless http.is_a?(Net::HTTPOK)
        end
      end
    end

    private

    def error(uri, http)
      message = "[#{http.code}] ERROR: #{http.body} while processing #{uri}"
      cli.error(message)
      raise UnsuccessfulResponse, message
    end

    def bm(prefix, message, &block)
      cb = -> (ms) { cli.info("[#{prefix} #{ms}ms.] #{message}") }
      Bm.measure(cb, &block)
    end
  end
end
