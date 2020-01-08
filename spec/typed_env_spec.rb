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

    context 'when decoding Base64' do
      subject { described_class.fetch(type, key, base64: true) }

      let(:value) { Base64.encode64(clear_value) }
      let(:clear_value) { 'a clear value' }

      it { is_expected.to eql clear_value }

      it 'does not pass the base64 argument to the ENV' do
        expect(ENV).to receive(:fetch).with(key).and_call_original
        subject
      end

      it 'passes a decoded value to the type' do
        expect(EnvironmentConfig::Types)
          .to receive(:convert).with(type, key, clear_value)

        subject
      end
    end
  end
end
