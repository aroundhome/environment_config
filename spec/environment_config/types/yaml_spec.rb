# frozen_string_literal: true

RSpec.describe EnvironmentConfig::Types::Yaml do
  describe '.convert' do
    it 'converts an empty string to nil' do
      expect(described_class.convert('')).to be_nil
    end

    it 'converts a YAML sequence to an array' do
      expect(described_class.convert('[1,2,3]')).to eq([1, 2, 3])
    end

    it 'converts a YAML mapping to a hash' do
      expect(described_class.convert('a: b')).to eq('a' => 'b')
    end

    it 'keeps an array as is' do
      expect(described_class.convert(%w[a b c])).to eq(%w[a b c])
    end

    it 'keeps a hash as is' do
      expect(described_class.convert(a: :b)).to eq(a: :b)
    end
  end
end
