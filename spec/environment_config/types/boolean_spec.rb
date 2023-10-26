# frozen_string_literal: true

RSpec.describe EnvironmentConfig::Types::Boolean do
  describe '.convert' do
    it 'converts "true" to true' do
      expect(described_class.convert('true')).to be true
    end

    it 'converts "false" to false' do
      expect(described_class.convert('false')).to be false
    end

    it 'converts already typed true to true' do
      expect(described_class.convert(true)).to be true
    end

    it 'converts already typed false to false' do
      expect(described_class.convert(false)).to be false
    end

    it 'rejects other values' do
      expect { described_class.convert('foo') }
        .to raise_error(EnvironmentConfig::Types::TypeError)
    end
  end
end
