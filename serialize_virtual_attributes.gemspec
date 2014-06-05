# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'serialize_virtual_attributes/version'

Gem::Specification.new do |spec|
  spec.name          = "serialize_virtual_attributes"
  spec.version       = SerializeVirtualAttributes::VERSION
  spec.authors       = ["Hao Liu"]
  spec.email         = ["leomayleomay@gmail.com"]
  spec.description   = %q{virtual attributes accessor via a serialized Hash column}
  spec.summary       = %q{Serialize specified virtual attributes into a Hash column}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", "~> 3.1"
  spec.add_dependency "activesupport", "~> 3.1"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "terminal-notifier-guard"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "byebug"
end
