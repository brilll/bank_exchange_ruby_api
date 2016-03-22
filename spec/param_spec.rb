require 'spec_helper'

RSpec.describe BankExchangeApi::Param do
  subject do
    Class.new do
      extend BankExchangeApi::Param
      param :array, Array
      param :unsupported, Float
    end.new
  end

  describe '#array' do
    context 'default' do
      it { expect(subject.array).to eq([]) }
    end

    context 'Array' do
      before do
        subject.array = [1, 'Lorem']
      end

      it { expect(subject.array).to eq([1, 'Lorem']) }
    end

    context 'String' do
      before do
        subject.array = 'Lorem'

        it { expect(subject.array).to eq('Lorem') }
      end
    end
  end

  describe '#unsupported' do
    it 'raises an error' do
      expect{ subject.unsupported }.to raise_error(BankExchangeApi::UnsupportedParamClass)
    end
  end
end
