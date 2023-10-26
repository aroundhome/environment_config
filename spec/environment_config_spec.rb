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

    it { is_expected.to be 42 }
  end

  context 'when two configurations have been loaded' do
    before do
      ENV['TEST_A'] = 'test_a'
      ENV['TEST_B'] = 'test_b'
    end

    let!(:config_a) { described_class.load { |c| c.string 'TEST_A' } }
    let!(:config_b) { described_class.load { |c| c.string 'TEST_B' } }

    it 'config A does not have an accessor for the value of config B' do
      expect(config_a).not_to respond_to(:b)
    end

    it 'config B does not have an accessor for the value of config A' do
      expect(config_b).not_to respond_to(:a)
    end
  end

  context 'when a boolean is added' do
    before do
      ENV['TEST_BOOLEAN_VALUE'] = 'true'
    end

    let!(:config) do
      described_class.load(strip_prefix: 'TEST_') do |c|
        c.boolean 'TEST_BOOLEAN_VALUE'
      end
    end

    it 'has the value available under the regular method name' do
      expect(config.boolean_value).to be true
    end

    it 'creates a ?-version of the method for a boolean' do
      expect(config.boolean_value?).to be true
    end
  end
end
