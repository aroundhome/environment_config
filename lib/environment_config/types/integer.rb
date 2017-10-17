# frozen_string_literal: true

class EnvironmentConfig
  module Types
    class Integer
      class << self
        def name
          :integer
        end

        def convert(value)
          Integer(value)
        end
      end
    end
  end
end
