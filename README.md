# BankExchangeApi

[![Build Status](https://semaphoreci.com/api/v1/shlima/bank_exchange_ruby_api/branches/master/badge.svg)](https://semaphoreci.com/shlima/bank_exchange_ruby_api) [![Code Climate](https://codeclimate.com/github/BankExchange/bank_exchange_ruby_api/badges/gpa.svg)](https://codeclimate.com/github/BankExchange/bank_exchange_ruby_api) [![Dependency Status](https://gemnasium.com/BankExchange/bank_exchange_ruby_api.svg)](https://gemnasium.com/BankExchange/bank_exchange_ruby_api)


> STATUS: WIP

## Configuration

```ruby
  BankExchangeApi::Config.api_token = "33f411e7-cebe-4f7e-a8f3-24bfc8ecca6e"
  BankExchangeApi::Config.logger = Logger.new(STDOUT)
```

## CLI

```ruby
  # @option api_token [String]
  # @option logger [Logger,StringIO]
  @cli = BankExchangeApi::Cli.new(api_token: '33f411e7-cebe-4f7e-a8f3-24bfc8ecca6e')
```

## Ping Query

```ruby
  # @return [Boolean]
  @cli.ping #=> true
```

## Banks [response methods overview]

```ruby
  # @option countries [Array]
  # @option countries [Array]
  request = @cli.banks(countries: ['US'])  
  request.currencies = ['USD']
  
  response = request.json
```

```ruby
  response.success? #=> true
```

```ruby
  # @return [Hash]
  response.data
  [{"swift"=>"XXXXXXXX", "name"=>"Board of Governors of the Federal Reserve System", "country"=>"US", "currency"=>"USD", "website"=>"http://www.federalreserve.gov"}] 
```

```ruby
  # @return [Hash]
  response.params
  {"countries"=>["US"], "currencies"=>["USD"]} 
```

```ruby
  # @return [Hash]
  response.body
  {params: {"countries"=>["US"], "currencies"=>["USD"]}, banks: [{"swift"=>"XXXXXXXX", "name"=>"Board of Governors of the Federal Reserve System", "country"=>"US", "currency"=>"USD", "website"=>"http://www.federalreserve.gov"}]} 
```
