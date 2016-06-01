require 'spec_helper'

RSpec.describe BankExchangeApi do

  subject { described_class::Cli.new }

  describe 'Version' do
    it {
      expect(described_class::VERSION).to be
    }
  end

  describe '#ping' do
    context 'online', vcr: {cassette_name: 'ping_online'} do
      it { expect(subject.ping).to be(true) }
    end

    context 'offline', vcr: {cassette_name: 'ping_offline'} do
      it { expect(subject.ping).to be(false) }
    end
  end

  describe 'Unsuccessful Response', vcr: {cassette_name: 'unsuccessful_response'} do
    it {
      expect { subject.banks(currencies: :LOREM).json }.to raise_error(BankExchangeApi::UnsuccessfulResponse, /should be 3 characters/)
    }
  end

  describe '#banks', vcr: {cassette_name: 'banks'} do
    let(:json) do
      subject.banks(currencies: :USD).json
    end

    let(:data) do
      [{"swift" => "XXXXXXXX",
        "name" => "Board of Governors of the Federal Reserve System",
        "country" => "US",
        "currency" => "USD",
        "website" => "http://www.federalreserve.gov"}]
    end

    let(:params) do
      {"countries" => [], "currencies" => ["USD"]}
    end

    it {
      expect(json.data).to eq(data)
      expect(json.params).to eq(params)
      expect(json.pagination).to eq({})
    }
  end

  describe '#bank', vcr: {cassette_name: 'bank'} do
    let(:json) do
      subject.bank('XXXXXXXX', iso_to: 'CHF', fallback_days: 18).json
    end

    let(:data) do
      [{"iso_from" => "USD",
        "iso_to" => "CHF",
        "swift" => "XXXXXXXX",
        "rate" => 0.9916,
        "inverse_rate" => 1.00847115772489,
        "date" => "2016-05-27"}
      ]
    end

    let(:params) do
      {"swift" => "XXXXXXXX", "iso_to" => ["CHF"], "date" => nil, "fallback_days" => 18}
    end

    let(:pagination) do
      {"current_page"=>1, "last_page"=>true, "per_page"=>200, "next_page_url"=>nil}
    end

    it {
      expect(json.data).to eq(data)
      expect(json.params).to eq(params)
      expect(json.pagination).to eq(pagination)
    }
  end

  describe '#rates', vcr: {cassette_name: 'rates'} do
    let(:json) do
      subject.rates(date: '2016-01-01', iso_from: 'BYR', iso_to: 'USD').json
    end

    let(:data) do
      [{"iso_from" => "BYR", "iso_to" => "USD", "rate" => 5.38531961871937e-05, "inverse_rate" => 18569.0, "swift" => "NBRBBY2X", "date" => "2016-01-01"}]
    end

    let(:params) do
      {"date" => "2016-01-01", "swift" => [], "iso_from" => ["BYR"], "iso_to" => ["USD"], "fallback_days" => 5}
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
      [{"iso_from" => "BYR",
        "iso_to" => "RUB",
        "rate" => 0.00391650021540751,
        "inverse_rate" => 255.33,
        "swift" => "NBRBBY2X",
        "date" => "2016-01-01"}]
    end

    let(:params) do
      {"iso_code" => "BYR",
       "date" => "2016-01-01",
       "iso_from" => ["BYR"],
       "iso_to" => ["RUB"],
       "fallback_days" => 5}
    end

    it {
      expect(json.data).to eq(data)
      expect(json.params).to eq(params)
    }
  end

  describe 'Pagination' do
    describe '#rates pagination', vcr: {cassette_name: 'rates_pagination'} do
      let(:expectation) do
        [
            {"iso_from" => "AFN", "iso_to" => "BTN", "swift" => "AFIBAFKA", "date" => "2016-06-01", "rate" => 0.955202312138727, "inverse_rate" => 1.04689863842663},
            {"iso_from" => "ZAR", "iso_to" => "RUB", "swift" => "SARBZAJP", "date" => "2016-06-01", "rate" => 4.21595896230333, "inverse_rate" => 0.237193959652222}
        ]
      end

      context 'block missing' do
        it 'returns first page' do
          expect(subject.rates(fallback_days: 0).json.data).to contain_exactly(expectation[0])
        end
      end

      context 'block given' do
        it 'yields each page-response to a block' do
          data = []

          subject.rates(fallback_days: 0).json do |response|
            data.concat(response.data)
          end

          expect(data).to match_array(expectation)
        end
      end
    end
  end
end
