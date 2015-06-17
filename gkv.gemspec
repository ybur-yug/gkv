# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gkv/version'

Gem::Specification.new do |spec|
  spec.name          = "gkv"
  spec.version       = Gkv::VERSION
  spec.authors       = ["="]
  spec.email         = ["="]

  spec.summary       = %q{Git as a key:value store.}
  spec.description   = %q{Utilize a git repository as a trivially simple kv store.}
  spec.homepage      = "https://www.github.com/ybur-yug/gkv"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = "gkv"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
