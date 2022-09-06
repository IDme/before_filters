# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'before_filters/version'

Gem::Specification.new do |spec|
  spec.name          = "before_filters"
  spec.version       = BeforeFilters::VERSION
  spec.authors       = ["Zac Hallett"]
  spec.email         = ["zac.hallett@gmail.com"]
  spec.description   = %q{An implementation of ActiveRecord before_filters in lightweight way for pure Ruby}
  spec.summary       = %q{An implementation of ActiveRecord before_filters in lightweight way for pure Ruby}
  spec.homepage      = "https://github.com/IDme/before_filters"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.3"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.11"
end
