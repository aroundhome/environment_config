# frozen_string_literal: true

class EnvironmentConfig
  module Types
    class IntegerList
      class << self
        def name
          :integer_list
        end

        def convert(value)
          return value if value.is_a? Array

          stringified_numbers = value.split(',')
          stringified_numbers.map { |number| Integer(number) }
        end
      end
    end
  end
end
