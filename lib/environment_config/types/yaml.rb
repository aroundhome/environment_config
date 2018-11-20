# frozen_string_literal: true

require 'yaml'

class EnvironmentConfig
  module Types
    class Yaml
      class << self
        def name
          :yaml
        end

        def convert(value)
          return value if value.is_a?(Array) || value.is_a?(Hash)
          return nil if value.empty?

          YAML.safe_load(value)
        end
      end
    end
  end
end
