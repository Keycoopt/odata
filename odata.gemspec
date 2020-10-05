# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'odata/version'

Gem::Specification.new do |spec|
  spec.name          = 'odata'
  spec.version       = OData::VERSION
  spec.authors       = ['James Thompson']
  spec.email         = %w{james@plainprograms.com}
  spec.summary       = %q{Simple OData library}
  spec.description   = %q{Provides a simple interface for working with OData APIs.}
  spec.homepage      = 'https://github.com/plainprogrammer/odata'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w{lib}

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'timecop'
  spec.add_development_dependency 'awesome_print'
  spec.add_development_dependency 'byebug'

  spec.add_dependency 'nokogiri', '~> 1.10'
  spec.add_dependency 'typhoeus', '~> 0.6.8'
  spec.add_dependency 'addressable'
end
