# frozen_string_literal: true

RSpec.describe EnvironmentConfig::Types::Symbol do
  describe '.convert' do
    it 'symbolizes a non-symbol' do
      expect(described_class.convert('foo')).to eq :foo
    end

    it 'keeps a symbol as is' do
      expect(described_class.convert(:foo)).to eq :foo
    end
  end
end
