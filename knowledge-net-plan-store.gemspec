# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'knowledge-net-plan-store/version'

Gem::Specification.new do |spec|
  spec.name          = "knowledge-net-plan-store"
  spec.version       = KnowledgeNetPlanStore::VERSION
  spec.authors       = ["Kaid"]
  spec.email         = ["kaid@kaid.me"]
  spec.summary       = %q{教学计划持久化保存.}
  spec.description   = %q{教学计划持久化保存.}
  spec.homepage      = "https://github.com/mindpin/knowledge-net-plan-store"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) {|f| File.basename(f)}
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "mongoid"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
