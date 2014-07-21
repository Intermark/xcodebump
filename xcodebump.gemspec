# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xcodebump/version'

Gem::Specification.new do |spec|
  spec.name          = "xcodebump"
  spec.version       = Xcodebump::VERSION
  spec.authors       = ["bennyguitar"]
  spec.email         = ["brgordon@ua.edu"]
  spec.summary       = 'Semantic versioning for Xcode made simple.'
  spec.description   = 'Quickly and easily bump your build and version numbers for an Xcode project or workspace.'
  spec.homepage      = 'https://github.com/intermark/xcodebump'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ['xcodebump']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "highline"
  spec.add_development_dependency "grit"

  spec.files         = Dir["./**/*"].reject { |file| file =~ /\.\/(bin|log|pkg|script|spec|test|vendor|(.*?)\.gem)/ }
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
