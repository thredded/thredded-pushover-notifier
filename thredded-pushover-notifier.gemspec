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
  spec.homepage      = 'https://github.com/thredded/thredded-pushover-notifier'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'thredded', '>= 0.13.4'
  spec.add_runtime_dependency 'actionview'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'rubocop', '= 0.58.2'
  spec.add_development_dependency 'rubocop-rspec', '= 1.28.0'
end
