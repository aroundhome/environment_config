# frozen_string_literal: true

class EnvironmentConfig
  module Types
    class Boolean
      BOOLEAN_VALUES = %w[true false].freeze

      class << self
        def name
          :boolean
        end

        def convert(value)
          # ensure compatibility when receiving correctly typed default value
          value = value.to_s

          raise TypeError.new(BOOLEAN_VALUES.join('/'), value) unless BOOLEAN_VALUES.include?(value)

          value == 'true'
        end
      end
    end
  end
end
