module BankExchangeApi::Request
  class Base
    attr_reader :cli, :params

    def initialize(cli, params={})
      @cli = cli
      @params = params
    end

    def query
      path
    end

    def get(*args)
      cli.connection.get(*args)
    end

    def json(root: nil)
      BankExchangeApi::Response::Json.new(get(query), root: root)
    end

    def path
      raise NotImplementedError, __method__
    end
  end
end
