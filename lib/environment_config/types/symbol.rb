# frozen_string_literal: true

class EnvironmentConfig
  module Types
    class Symbol
      class << self
        def name
          :symbol
        end

        def convert(value)
          value.to_sym
        end
      end
    end
  end
end
