# frozen_string_literal: true

RSpec.describe EnvironmentConfig::Types::StringList do
  describe '.convert' do
    it 'converts an empty string to an empty array' do
      expect(described_class.convert('')).to eq []
    end

    it 'converts an array string to an array of integers' do
      expect(described_class.convert('1,2,3')).to eq [1, 2, 3]
    end

    it 'keeps an array as is' do
      expect(described_class.convert([1, 2, 3])).to eq [1, 2, 3]
    end
  end
end
