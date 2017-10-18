# frozen_string_literal: true

require 'environment_config/types'

class EnvironmentConfig
  class TypedEnv
    class << self
      def fetch(type, key, *args)
        Types.convert(type, key, fetch_raw(key, *args))
      end

      private

      def fetch_raw(key, *args)
        ENV.fetch(key, *args)
      rescue KeyError => e
        raise e,
              "Expected environment variable #{key} to be set, but was missing."
      end
    end
  end
end
