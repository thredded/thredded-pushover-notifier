# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thredded/pushover_notifier'

Gem::Specification.new do |spec|
  spec.name          = 'thredded-pushover-notifier'
  spec.version       = Thredded::PushoverNotifier::VERSION
  spec.authors       = ['Tim Diggins', 'Ella Schofield']
  spec.email         = ['tim@red56.uk']

  spec.summary       = 'A notifier for Thredded to push new post notifications to the Pushover app'
  spec.homepage      = 'https://github.com/red56/thredded-pushover-notifier'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'thredded', '~> 0.13', '>= 0.13.4'
  spec.add_runtime_dependency 'sqlite3'
  spec.add_runtime_dependency 'actionview'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
