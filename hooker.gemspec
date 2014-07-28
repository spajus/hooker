# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hooker/version'

Gem::Specification.new do |spec|
  spec.name          = 'mass-hooker'
  spec.version       = Hooker::VERSION
  spec.authors       = ['Tomas Varaneckas']
  spec.email         = ['tomas.varaneckas@gmail.com']
  spec.summary       = %q{Control GitHub repository hooks in multiple repos in bulk}
  spec.description   = %q{Command line tool to control GitHub repository hooks in multiple repos in bulk}
  spec.homepage      = 'https://github.com/spajus/hooker'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'thor', '~> 0.19'
  spec.add_runtime_dependency 'octokit', '~> 3.0'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
