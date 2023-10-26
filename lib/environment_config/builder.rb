# frozen_string_literal: true

require 'environment_config/typed_env'
require 'environment_config/types'

class EnvironmentConfig
  class Builder
    attr_reader :config

    def initialize(strip_prefix: nil)
      @strip_prefix = strip_prefix
      @config = EnvironmentConfig.new
    end

    def method_missing(method_name, *args, **opts)
      if Types.known_type?(method_name)
        type = method_name
        key = args.shift
        convert_and_store(type, key, *args, **opts)
      else
        super
      end
    end

    def respond_to_missing?(method_name, *args)
      Types.known_type?(method_name) || super
    end

    private

    def convert_and_store(type, key, *args, **opts)
      value = TypedEnv.fetch(type, key, *args, **opts)
      store(key, value)
    end

    def store(key, value)
      key = key[@strip_prefix.size..] if @strip_prefix && key.start_with?(@strip_prefix)
      config.store(key.downcase, value)
    end
  end
end
