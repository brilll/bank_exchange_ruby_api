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

    context 'offline',  vcr: {cassette_name: 'ping_offline'} do
      it { expect(subject.ping).to be(false) }
    end
  end
end
