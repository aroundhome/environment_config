# frozen_string_literal: true

require 'environment_config/types'

require 'base64'

class EnvironmentConfig
  class TypedEnv
    class << self
      def fetch(type, key, *args)
        Types.convert(type, key, fetch_raw(key, *args))
      end

      private

      def fetch_raw(key, *options, base64: false)
        result = ENV.fetch(key, *options)
        return Base64.decode64(result) if base64

        result
      rescue KeyError => e
        raise e,
              "Expected environment variable #{key} to be set, but was missing."
      end
    end
  end
end
