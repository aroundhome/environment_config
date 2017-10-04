# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'environment_config/version'

Gem::Specification.new do |spec|
  spec.name          = 'environment_config'
  spec.version       = EnvironmentConfig::VERSION
  spec.authors       = ['Jan Sandbrink']
  spec.email         = ['jan.sandbrink@kaeuferportal.de']

  spec.summary       = 'Gem to unify reading configuration from env variables.'
  spec.homepage      = 'https://codevault.io/kaeuferportal/environment_config'

  spec.files         = `git ls-files -z`.split("\x0")
                                        .reject { |f| f.match(%r{^spec/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rspec', '~> 3.6'
end
