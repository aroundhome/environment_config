# frozen_string_literal: true

class EnvironmentConfig
  module Types
    class String
      class << self
        def name
          :string
        end

        def convert(value)
          value.to_s
        end
      end
    end
  end
end
