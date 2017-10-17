# frozen_string_literal: true

require 'environment_config/types'

class EnvironmentConfig
  class Builder
    attr_reader :config

    def initialize(strip_prefix: nil)
      @strip_prefix = strip_prefix
      @config = EnvironmentConfig.new
    end

    def method_missing(method_name, *args)
      if Types.known_type?(method_name)
        type = method_name
        key = args.shift
        convert_and_store(type, key, *args)
      else
        super
      end
    end

    def respond_to_missing?(method_name, *args)
      Types.known_type?(method_name) || super
    end

    private

    def convert_and_store(type, key, *args)
      value = Types.convert(type, from_env(key, *args))
      store(key, value)
    rescue Types::TypeError => e
      raise ArgumentError,
            "Environment variable #{key} could not be read as #{type}. " \
            "Expected: #{e.expected_message} " \
            "Got: #{e.value}"
    end

    def from_env(key, *args)
      ENV.fetch(key, *args)
    rescue KeyError => e
      raise e,
            "Expected environment variable #{key} to be set, but was missing."
    end

    def store(key, value)
      if @strip_prefix && key.start_with?(@strip_prefix)
        key = key[@strip_prefix.size..-1]
      end
      config.store(key.downcase, value)
    end
  end
end
