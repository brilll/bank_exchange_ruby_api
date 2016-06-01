require 'date'
require 'uri'

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

      def json(root: nil, &block)
        paginator = -> (uri=query) { BankExchangeApi::Response::Json.new(get(uri), root: root) }

        if block_given?
          paginate(paginator) { |response| yield(response) }
        else
          paginate(paginator)
        end
      end

      def params
        {}
      end

      def endpoint
        raise NotImplementedError, __method__
      end

      private

      # @param paginator [Proc] should accept next page uri
      # @block if not given - first response return
      def paginate(paginator)
        response = paginator.call

        unless block_given?
          if response.paginatable?
            cli.warn('Requested resource contains a pagination, please provide a block to process each page. Initial page returned.')
          end
          return response
        end

        yield(response)

        while response.paginatable? do
          response = paginator.call(response.next_page_url)
          yield(response)
        end
      end
    end
  end
end
