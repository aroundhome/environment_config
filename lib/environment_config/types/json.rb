# frozen_string_literal: true

require 'json'

class EnvironmentConfig
  module Types
    class Json
      class << self
        def name
          :json
        end

        def convert(value)
          return value if value.is_a?(Array) || value.is_a?(Hash)
          return nil if value.empty?

          JSON.parse(value)
        end
      end
    end
  end
end
