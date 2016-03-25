require 'spec_helper'

RSpec.describe BankExchangeApi do

  subject { described_class::Cli.new }

  describe 'Version' do
    it {
      expect(described_class::VERSION).to be
    }
  end

  describe '#ping' do
    context 'online',  vcr: {cassette_name: 'ping_online'} do
      it { expect(subject.ping).to be(true) }
    end

    context 'offline', vcr: {cassette_name: 'ping_offline'} do
      it { expect(subject.ping).to be(false) }
    end
  end

  describe 'Unsuccessful Response', vcr: {cassette_name: 'unsuccessful_response'} do
    it {
      expect{ subject.banks(currencies: :LOREM).json }.to raise_error(BankExchangeApi::UnsuccessfulResponse, /should be 3 characters/)
    }
  end

  describe '#banks', vcr: {cassette_name: 'banks'} do
    let(:json) do
      subject.banks(currencies: :USD).json
    end

    let(:data) do
      [{"swift"=>"XXXXXXXX",
        "name"=>"Board of Governors of the Federal Reserve System",
        "country"=>"US",
        "currency"=>"USD",
        "website"=>"http://www.federalreserve.gov"}]
    end

    let(:params) do
      {"countries"=>[], "currencies"=>["USD"]}
    end

    it {
      expect(json.data).to eq(data)
      expect(json.params).to eq(params)
    }
  end

  describe '#bank', vcr: {cassette_name: 'bank'} do
    let(:json) do
      subject.bank('XXXXXXXX', currencies: :EUR).json
    end

    let(:data) do
      [{"iso_from"=>"USD",
        "iso_to"=>"EUR",
        "rate"=>0.916086478563577,
        "inverse_rate"=>1.0916,
        "date"=>"2016-12-29"}]
    end

    let(:params) do
      {"swift"=>"XXXXXXXX", "currencies"=>["EUR"], "date"=>nil, "fallback_days"=>4}
    end

    it {
      expect(json.data).to eq(data)
      expect(json.params).to eq(params)
    }
  end

  describe '#rates', vcr: {cassette_name: 'rates'} do
    let(:json) do
      subject.rates(date: '2016-01-01', iso_from: 'BYR', iso_to: 'USD').json
    end

    let(:data) do
      [{"iso_from"=>"BYR", "iso_to"=>"USD", "rate"=>5.38531961871937e-05, "inverse_rate"=>18569.0, "swift"=>"NBRBBY2X", "date"=>"2016-01-01"}]
    end

    let(:params) do
      {"date"=>"2016-01-01", "swift"=>[], "iso_from"=>["BYR"], "iso_to"=>["USD"], "fallback_days"=>5}
    end

    it {
      expect(json.data).to eq(data)
      expect(json.params).to eq(params)
    }
  end

  describe '#rate', vcr: {cassette_name: 'rate'} do
    let(:json) do
      subject.rate('BYR', date: '2016-01-01', iso_from: 'BYR', iso_to: 'RUB').json
    end

    let(:data) do
      [{"iso_from"=>"BYR",
        "iso_to"=>"RUB",
        "rate"=>0.00391650021540751,
        "inverse_rate"=>255.33,
        "swift"=>"NBRBBY2X",
        "date"=>"2016-01-01"}]
    end

    let(:params) do
      {"iso_code"=>"BYR",
       "date"=>"2016-01-01",
       "iso_from"=>["BYR"],
       "iso_to"=>["RUB"],
       "fallback_days"=>5}
    end

    it {
      expect(json.data).to eq(data)
      expect(json.params).to eq(params)
    }
  end
end
