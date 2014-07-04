# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fluent_accessors/version'

Gem::Specification.new do |spec|
  spec.name          = "fluent_accessors"
  spec.version       = FluentAccessors::VERSION
  spec.authors       = ["Eduardo Turiño"]
  spec.email         = ["(none)"]
  spec.summary       = %q{Gem that provides a macro for creating fluent accessors for instance variables, working similar to attr_accessor}
  # spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]


  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-nc"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-nav"
  spec.add_development_dependency "pry-rescue"
  spec.add_development_dependency "pry-stack_explorer"
  spec.add_development_dependency "pry-doc"

end
