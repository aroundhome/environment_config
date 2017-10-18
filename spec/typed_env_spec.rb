# frozen_string_literal: true

RSpec.describe EnvironmentConfig::TypedEnv do
  describe '.fetch' do
    subject { described_class.fetch(type, key) }

    let(:type) { 'string' }
    let(:key) { 'TEST_ENV_VARIABLE' }
    let(:value) { '42' }

    before do
      ENV[key] = value
    end

    it { is_expected.to eql value }

    context 'when specifying a type' do
      let(:type) { 'integer' }

      it { is_expected.to eql 42 }
    end

    context 'when the value is not set in the environment' do
      before do
        ENV.delete key
      end

      it 'raises an error' do
        expect { subject }.to raise_error(KeyError)
      end

      it 'indicates the expected environment variable in the message' do
        expect { subject }.to raise_error(/#{key}/)
      end

      context 'and a default value is given' do
        subject { described_class.fetch(type, key, default) }

        let(:default) { 'a default value' }

        it { is_expected.to eql default }
      end
    end
  end
end
