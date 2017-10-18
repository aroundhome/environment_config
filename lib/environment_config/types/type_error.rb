# frozen_string_literal: true

class EnvironmentConfig
  module Types
    class TypeError < StandardError
      attr_reader :expected_message, :value

      def initialize(expected_message, value)
        @expected_message = expected_message
        @value = value

        super()
      end
    end
  end
end
