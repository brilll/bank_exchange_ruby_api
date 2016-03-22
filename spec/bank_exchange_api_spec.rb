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
end
