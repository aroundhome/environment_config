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

  describe '.store' do
    it 'creates a method to return the the value' do
      parts = key.split('_')
      prefix = parts[0] + '_'
      method = parts[1..-1].join('_').downcase

      config = EnvironmentConfig.load(strip_prefix: prefix) do |c|
        c.string key
      end

      expect(config.send(method)).to eql value
    end

    it 'also creates a ?-version of the method for a boolean' do
      ENV['TEST_BOOLEAN_VALUE'] = 'true'

      config = EnvironmentConfig.load(strip_prefix: 'TEST_') do |c|
        c.boolean 'TEST_BOOLEAN_VALUE'
      end

      expect(config.boolean_value).to be true
      expect(config.boolean_value?).to be true
    end
  end
end
