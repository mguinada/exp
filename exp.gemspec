# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'exp/version'

Gem::Specification.new do |gem|
  gem.name          = "exp"
  gem.version       = Exp::VERSION
  gem.authors       = ["Miguel Guinada"]
  gem.email         = ["mguinada@gmail.com"]
  gem.summary       = %q{a simple mathematical expression interpreter}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'racc', '~> 1.4.9'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'simplecov'
end
