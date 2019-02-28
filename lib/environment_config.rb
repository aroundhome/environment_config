# frozen_string_literal: true

require 'environment_config/builder'
require 'environment_config/type_fetcher_methods'

class EnvironmentConfig
  include TypeFetcherMethods

  class << self
    # Accepts the same block as `load` does, but only validates
    # the presence and type of environment variables. Does not return
    # a configuration.
    def ensure(&block)
      load(&block)
      nil
    end

    # Loads a configuration from environment variables as specified
    # by the block given (using the environment config DSL)
    def load(**options)
      builder = Builder.new(**options)
      yield builder
      builder.config
    end
  end

  def initialize
    @store = {}
  end

  def to_h
    # This method solely exists for purposes of "irb discoverability"
    raise NotImplementedError,
          'Please choose between to_string_hash and to_symbol_hash, ' \
          'depending on the key type you want to get.'
  end

  def to_string_hash
    @store.dup
  end

  def to_symbol_hash
    @store.map { |k, v| [k.to_sym, v] }.to_h
  end

  def store(key, value)
    @store[key.to_s] = value

    define_corresponding_method(key, value)
  end

  private

  def define_corresponding_method(key, value)
    self.class.send :define_method, key do
      value
    end
  end
end
