# frozen_string_literal: true

class EnvironmentConfig
  module Types
    class StringList
      class << self
        def name
          :string_list
        end

        def convert(value)
          return value if value.is_a? Array

          value.split(',')
        end
      end
    end
  end
end
