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
end
