module BankExchangeApi
  module Request
    class Base
      extend Param

      attr_reader :cli

      def initialize(cli, params={})
        @cli = cli
        params.each{ |k,v| public_send("#{k}=", v) }
      end

      def query
        [endpoint, URI.encode_www_form(params)].join('?')
      end

      def get(*args)
        cli.connection.get(*args)
      end

      def json(root: nil)
        BankExchangeApi::Response::Json.new(get(query), root: root)
      end

      def params
        {}
      end

      def endpoint
        raise NotImplementedError, __method__
      end
    end
  end
end
