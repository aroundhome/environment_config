# frozen_string_literal: true

RSpec.describe EnvironmentConfig do
  let(:key) { 'TEST_ENV_VARIABLE' }
  let(:value) { '42' }

  before do
    ENV[key] = value
  end

  describe '.fetch_string' do
    subject { described_class.fetch_string(key) }

    it { is_expected.to eql value }
  end

  describe '.fetch_integer' do
    subject { described_class.fetch_integer(key) }

    it { is_expected.to eql 42 }
  end

  context 'when a boolean is added' do
    before do
      ENV['TEST_BOOLEAN_VALUE'] = 'true'
    end

    let!(:config) do
      EnvironmentConfig.load(strip_prefix: 'TEST_') do |c|
        c.boolean 'TEST_BOOLEAN_VALUE'
      end
    end

    it 'creates a ?-version of the method for a boolean' do
      expect(config.boolean_value).to be true
      expect(config.boolean_value?).to be true
    end
  end
end
