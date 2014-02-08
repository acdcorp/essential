# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'essential/version'

Gem::Specification.new do |spec|
  spec.name          = "essential"
  spec.version       = Essential::VERSION
  spec.authors       = ["cj"]
  spec.email         = ["cjlazell@gmail.com"]
  spec.description   = %q{All the essentials.}
  spec.summary       = %q{Has all the essentials you need to get a project off the ground.}
  # spec.homepage      = ""
  # spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "bundler", ">= 1.3"
  spec.add_dependency "rake"
  spec.add_dependency "rspec"
  spec.add_dependency "turnip"
  spec.add_dependency "awesome_print"
  spec.add_dependency "pry"
  spec.add_dependency "dotenv-rails"
  spec.add_dependency "database_cleaner"
end
