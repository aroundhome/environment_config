# frozen_string_literal: true

RSpec.describe EnvironmentConfig do
  context 'only one configuration' do
    before do
      ENV['TEST_ENV_VARIABLE_S'] = '42'
      ENV['TEST_ENV_VARIABLE_I'] = '42'
    end

    let!(:config) do
      EnvironmentConfig.load(strip_prefix: 'TEST_') do |c|
        c.string 'TEST_ENV_VARIABLE_S'
        c.integer 'TEST_ENV_VARIABLE_I'
      end
    end

    it 'returns a string' do
      expect(config.env_variable_s).to eql '42'
    end

    it 'returns a integer' do
      expect(config.env_variable_i).to eql 42
    end
  end

  context 'multiple configurations' do
    before do
      ENV['TEST_ENV_VARIABLE'] = '42'
      ENV['TEST_BOOLEAN_VALUE_FALSE'] = 'false'
      ENV['PROOF_BOOLEAN_VALUE_FALSE'] = 'true'
    end

    let!(:config) do
      EnvironmentConfig.load(strip_prefix: 'TEST_') do |c|
        c.integer 'TEST_ENV_VARIABLE'
        c.boolean 'TEST_BOOLEAN_VALUE_FALSE'
      end
    end

    let!(:other_config) do
      EnvironmentConfig.load(strip_prefix: 'PROOF_') do |c|
        c.boolean 'PROOF_BOOLEAN_VALUE_FALSE'
      end
    end

    it 'returns a integer from the first config' do
      expect(config.env_variable).to eql 42
    end

    it 'returns a boolean from the first config' do
      expect(config.boolean_value_false).to be false
    end

    it 'does not respond to methods from other configs' do
      expect(other_config).to receive(:method_missing).once
      other_config.env_variable
    end

    it 'returns the correct boolean from the other config' do
      expect(other_config.boolean_value_false).to be true
    end
  end
end
