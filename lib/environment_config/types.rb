# frozen_string_literal: true

require 'environment_config/types/boolean'
require 'environment_config/types/integer'
require 'environment_config/types/integer_list'
require 'environment_config/types/json'
require 'environment_config/types/string'
require 'environment_config/types/string_list'
require 'environment_config/types/symbol'
require 'environment_config/types/yaml'

require 'environment_config/types/type_error'

class EnvironmentConfig
  module Types
    ALL = [
      ::EnvironmentConfig::Types::Boolean,
      ::EnvironmentConfig::Types::Integer,
      ::EnvironmentConfig::Types::IntegerList,
      ::EnvironmentConfig::Types::Json,
      ::EnvironmentConfig::Types::String,
      ::EnvironmentConfig::Types::StringList,
      ::EnvironmentConfig::Types::Symbol,
      ::EnvironmentConfig::Types::Yaml
    ].freeze

    class << self
      def convert(type_name, key, value)
        type = type_map.fetch(type_name.to_sym)
        type.convert(value)
      rescue Types::TypeError => e
        raise ArgumentError,
              "Environment variable #{key} could not be read as #{type_name}. " \
              "Expected: #{e.expected_message} " \
              "Got: #{e.value}"
      end

      def type_names
        type_map.keys
      end

      def known_type?(type_name)
        type_map.key?(type_name.to_sym)
      end

      private

      def type_map
        @type_map ||= ALL.to_h { |type| [type.name, type] }
      end
    end
  end
end
