# frozen_string_literal: true

class EnvironmentConfig
  class Builder
    BOOLEAN_VALUES = ['true', 'false'].freeze

    attr_reader :config

    def initialize
      @config = EnvironmentConfig.new
    end

    def string(key, *args)
      store(key, from_env(key, *args).to_s)
    end

    def symbol(key, *args)
      store(key, from_env(key, *args).to_sym)
    end

    def integer(key, *args)
      store(key, Integer(from_env(key, *args)))
    end

    def boolean(key, *args)
      value = from_env(key, *args).to_s
      unless BOOLEAN_VALUES.include?(value)
        raise ArgumentError,
              "Environment variable #{key} could not be read as boolean. " \
              "Expected: #{BOOLEAN_VALUES.join('/')} " \
              "Got: #{value}"
      end

      store(key, value == 'true')
    end

    def string_list(key, *args)
      value = from_env(key, *args)
      value = value.split(',') unless value.is_a? Array
      store(key, value)
    end

    private

    def from_env(key, *args)
      ENV.fetch(key, *args)
    rescue KeyError => e
      raise e,
            "Expected environment variable #{key} to be set, but was missing."
    end

    def store(key, value)
      config.store(key.downcase, value)
    end
  end
end
