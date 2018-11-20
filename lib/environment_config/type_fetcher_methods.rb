# frozen_string_literal: true

require 'environment_config/typed_env'
require 'environment_config/types'

class EnvironmentConfig
  module TypeFetcherMethods
    class << self
      def included(base)
        base.extend(ClassMethods)
      end
    end

    module ClassMethods
      def method_missing(method_name, *args)
        type = type_of_fetch_method(method_name)
        if type && Types.known_type?(type)
          key = args.shift
          TypedEnv.fetch(type, key, *args)
        else
          super
        end
      end

      def respond_to_missing?(method_name, *_args)
        type = type_of_fetch_method(method_name)
        (type && Types.known_type?(type)) || super
      end

      private

      def type_of_fetch_method(method_name)
        match = /\Afetch_(.+)/.match(method_name)
        return nil unless match

        match[1]
      end
    end
  end
end
