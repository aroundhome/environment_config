# frozen_string_literal: true

RSpec.describe EnvironmentConfig::Types::String do
  describe '.convert' do
    it 'stringifies a non-string' do
      expect(described_class.convert(42)).to eq '42'
    end

    it 'keeps a string as is' do
      expect(described_class.convert('foo')).to eq 'foo'
    end
  end
end
