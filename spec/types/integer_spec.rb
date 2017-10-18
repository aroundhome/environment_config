# frozen_string_literal: true

RSpec.describe EnvironmentConfig::Types::Integer do
  describe '.convert' do
    it 'converts a stringified integer' do
      expect(described_class.convert('42')).to eq 42
    end

    it 'keeps an actual integer the same' do
      expect(described_class.convert(42)).to eq 42
    end

    it 'fails for mixed character strings' do
      expect { described_class.convert('42 horses') }
        .to raise_error(EnvironmentConfig::Types::TypeError)
    end
  end
end
