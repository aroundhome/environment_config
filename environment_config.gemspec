# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'environment_config/version'

Gem::Specification.new do |spec|
  spec.name          = 'environment_config'
  spec.version       = EnvironmentConfig::VERSION
  spec.authors       = ['be Around GmbH']
  spec.email         = ['oss@aroundhome.de']
  spec.licenses      = ['MIT']

  spec.summary       = 'Gem to unify reading configuration from env variables.'
  spec.homepage      = 'https://github.com/aroundhome/environment_config'

  spec.files         = `git ls-files -z`.split("\x0")
                                        .reject { |f| f.match(%r{^spec/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '~> 3.0'

  spec.add_dependency 'base64', '~> 0.2.0'

  spec.add_development_dependency 'aroundhome_cops', '~> 5.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rspec', '~> 3.6'
end
