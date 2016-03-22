require 'spec_helper'

RSpec.describe BankExchangeApi::Param do
  subject do
    Class.new do
      extend BankExchangeApi::Param
      param :array, Array
      param :integer, Integer
      param :string, String
      param :date, Date
      param :unsupported, Float
    end.new
  end

  describe '#array' do
    context 'Default' do
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
      end

      it { expect(subject.array).to eq(['Lorem']) }
    end
  end

  describe '#string' do
    context 'Default' do
      it { expect(subject.string).to eq(nil) }
    end

    context 'String' do
      before do
        subject.string = 'Lorem'
      end

      it { expect(subject.string).to eq('Lorem') }
    end

    context 'Not-integer' do
      before do
        subject.string = [1]
      end

      it { expect(subject.string).to eq('[1]') }
    end
  end

  describe '#integer' do
    context 'Default' do
      it { expect(subject.integer).to eq(nil) }
    end

    context 'String' do
      before do
        subject.integer = '1'
      end

      it { expect(subject.integer).to eq(1) }
    end

    context 'Integer' do
      before do
        subject.integer = 3
      end

      it { expect(subject.integer).to eq(3) }
    end
  end

  describe '#date' do
    context 'Default' do
      it { expect(subject.date).to eq(nil) }
    end

    context 'Date' do
      before do
        subject.date = Date.today
      end

      it { expect(subject.date).to eq(Date.today) }
    end

    context 'String' do
      before do
        subject.date = '2016-01-01'
      end

      it { expect(subject.date).to eq(Date.new(2016, 1, 1)) }
    end
  end

  describe '#unsupported' do
    it 'raises an error' do
      expect{ subject.unsupported }.to raise_error(BankExchangeApi::UnsupportedParamClass)
    end
  end
end
