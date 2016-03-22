require 'spec_helper'

RSpec.describe BankExchangeApi::Config do
  subject do
    Class.new(described_class) do
      conf_accessor :param
    end.new
  end

  describe '#param, #param!' do
    context 'instance variable is nil' do
      before do
        subject.class.param = :lorem
      end

      it 'uses class variable' do
        expect(subject.param).to eq(:lorem)
        expect(subject.param!).to eq(:lorem)
      end
    end

    context 'class variable is nil' do
      before do
        subject.param = :lorem
      end

      it 'uses instance variable' do
        expect(subject.param).to eq(:lorem)
        expect(subject.param!).to eq(:lorem)
      end

      it 'raises an error on class level' do
        expect{ subject.class.param! }.to raise_error(BankExchangeApi::ConfigurationError)
      end
    end
  end
end
