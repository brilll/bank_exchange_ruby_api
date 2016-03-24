# BankExchangeApi

[![Build Status](https://semaphoreci.com/api/v1/shlima/bank_exchange_ruby_api/branches/master/badge.svg)](https://semaphoreci.com/shlima/bank_exchange_ruby_api) [![Code Climate](https://codeclimate.com/github/BankExchange/bank_exchange_ruby_api/badges/gpa.svg)](https://codeclimate.com/github/BankExchange/bank_exchange_ruby_api) [![Dependency Status](https://gemnasium.com/BankExchange/bank_exchange_ruby_api.svg)](https://gemnasium.com/BankExchange/bank_exchange_ruby_api)

> STATUS: WIP

This is the Ruby API client for the BankExchange service. Please read the official documentation to get further information http://bank.exchange/documentation

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

## Banks list [response methods overview]

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
  response.params
  {"countries"=>["US"], "currencies"=>["USD"]} 
```

```ruby
  # @return [Hash]
  response.data
  [{"swift"=>"XXXXXXXX", "name"=>"Board of Governors of the Federal Reserve System", "country"=>"US", "currency"=>"USD", "website"=>"http://www.federalreserve.gov"}] 
```

```ruby
  # @return [Hash]
  response.body
  {params: {"countries"=>["US"], "currencies"=>["USD"]}, banks: [{"swift"=>"XXXXXXXX", "name"=>"Board of Governors of the Federal Reserve System", "country"=>"US", "currency"=>"USD", "website"=>"http://www.federalreserve.gov"}]} 
```

## Bank overview

```ruby
  # @param swift [String]
  # @option currencies [Array]
  # @option date [Date,String]
  # @option fallback_days [Integer]
  response = @cli.bank("XXXXXXXX", date: Date.today, currencies: ['EUR']).json
```

```ruby  
  response.params
  {"swift"=>"XXXXXXXX", "currencies"=>["EUR"], "date"=>"2016-03-22", "fallback_days"=>5}  
```

```ruby  
  response.data
  [{"iso_from"=>"USD", "iso_to"=>"EUR", "rate"=>0.885582713425434, "inverse_rate"=>1.1292, "date"=>"2016-03-18"}]   
```

```ruby  
  response.body
  {"params"=>{"swift"=>"XXXXXXXX", "currencies"=>["EUR"], "date"=>"2016-03-22", "fallback_days"=>4}, "bank"=>{"swift"=>"XXXXXXXX", "name"=>"Board of Governors of the Federal Reserve System", "country"=>"US", "currency"=>"USD", "website"=>"http://www.federalreserve.gov"}, "rates"=>[{"iso_from"=>"USD", "iso_to"=>"EUR", "rate"=>0.885582713425434, "inverse_rate"=>1.1292, "date"=>"2016-03-18"}]}    
```

## Rates list

```ruby
  # @param swift [Array]
  # @option iso_from [Array]
  # @option iso_to [Array]
  # @option date [Date,String]
  # @option fallback_days [Integer]
  response = @cli.rates(date: Date.today, iso_from: ['BYR'], iso_to: ['USD']).json
```

```ruby  
  response.params
  {"date"=>"2016-03-24", "swift"=>[], "iso_from"=>["BYR"], "iso_to"=>["USD"], "fallback_days"=>5}   
```

```ruby  
  response.data
  [{"iso_from"=>"BYR", "iso_to"=>"USD", "rate"=>4.96007142502852e-05, "inverse_rate"=>20161.0, "swift"=>"NBRBBY2X", "date"=>"2016-03-24"}]    
```

```ruby  
  response.data
  {"params"=>{"date"=>"2016-03-24", "swift"=>[], "iso_from"=>["BYR"], "iso_to"=>["USD"], "fallback_days"=>5}, "rates"=>[{"iso_from"=>"BYR", "iso_to"=>"USD", "rate"=>4.96007142502852e-05, "inverse_rate"=>20161.0, "swift"=>"NBRBBY2X", "date"=>"2016-03-24"}]}      
```
