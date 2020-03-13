# frozen_string_literal: true

RSpec.describe EnvironmentConfig::Types::IntegerList do
  describe '.convert' do
    context 'valid values' do
      it 'converts an empty string to an empty array' do
        expect(described_class.convert('')).to eq []
      end

      it 'converts an array string to an array of integers' do
        expect(described_class.convert('1,2,3')).to eq [1, 2, 3]
      end

      it 'ignores whitespaces' do
        expect(described_class.convert('1, 2, 3')).to eq [1, 2, 3]
      end

      it 'keeps an array as is' do
        expect(described_class.convert([1, 2, 3])).to eq [1, 2, 3]
      end
    end

    context 'invalid values' do
      it 'throws an Argument error when not supplying integers' do
        expect do
          described_class.convert('1,B,3')
        end.to raise_error(ArgumentError)
      end

      it 'throws an Argument error when combining invalid with valid values' do
        expect do
          described_class.convert('1,2 B,3')
        end.to raise_error(ArgumentError)
      end
    end
  end
end
