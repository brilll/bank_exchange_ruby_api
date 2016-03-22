require 'spec_helper'

RSpec.describe BankExchangeApi::Bm do

  subject do
    described_class.measure(cb) do
      action
    end
  end

  describe '.measure' do
    let(:cb) do
      -> (ms) { ms }
    end

    let(:action) do
      :lorem
    end

    it 'returns a result of a block' do
      expect(subject).to eq(action)
    end

    it '' do
      expect(cb).to receive(:call).with(0)
      subject
    end
  end
end
