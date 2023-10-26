# frozen_string_literal: true

RSpec.describe EnvironmentConfig::Types::StringList do
  describe '.convert' do
    it 'converts an empty string to an empty array' do
      expect(described_class.convert('')).to eq []
    end

    it 'converts an array string to an array' do
      expect(described_class.convert('a,b,c')).to eq %w[a b c]
    end

    it 'keeps an array as is' do
      expect(described_class.convert(%w[a b c])).to eq %w[a b c]
    end
  end
end
