# frozen_string_literal: true

require 'environment_config/types/boolean'
require 'environment_config/types/integer'
require 'environment_config/types/string'
require 'environment_config/types/string_list'
require 'environment_config/types/symbol'

require 'environment_config/types/type_error'

class EnvironmentConfig
  module Types
    ALL = [
      ::EnvironmentConfig::Types::Boolean,
      ::EnvironmentConfig::Types::Integer,
      ::EnvironmentConfig::Types::String,
      ::EnvironmentConfig::Types::StringList,
      ::EnvironmentConfig::Types::Symbol
    ].freeze

    class << self
      def convert(type_name, value)
        type = type_map.fetch(type_name.to_sym)
        type.convert(value)
      end

      def type_names
        type_map.keys
      end

      def known_type?(type_name)
        type_map.key?(type_name.to_sym)
      end

      private

      def type_map
        @type_map ||= ALL.map { |type| [type.name, type] }.to_h
      end
    end
  end
end
