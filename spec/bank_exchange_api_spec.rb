require 'spec_helper'

describe BankExchangeApi do
  describe 'Version' do
    it {
      expect(described_class::VERSION).to be
    }
  end
end
