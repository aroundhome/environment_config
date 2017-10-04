# frozen_string_literal: true

require 'environment_config/builder'

class EnvironmentConfig
  class << self
    def load
      builder = Builder.new
      yield builder
      builder.config
    end
  end

  def initialize
    @store = {}
  end

  def method_missing(method_name, *_arguments, &block)
    return fetch method_name if known_key?(method_name)
    super
  end

  def respond_to_missing?(method_name, _include_private = false)
    known_key?(method_name) || super
  end

  def to_h
    # This method solely exists for purposes of "irb discoverability"
    raise NotImplementedError,
          'Please choose between to_string_h and to_symbol_h, ' \
          'depending on the key type you want to get.'
  end

  def to_string_h
    @store.dup
  end

  def to_symbol_h
    @store.map { |k,v| [k.to_sym, v] }.to_h
  end

  def fetch(key)
    @store[key.to_s]
  end

  def store(key, value)
    @store[key.to_s] = value
  end

  private

  def known_key?(key)
    @store.key? key.to_s
  end
end
