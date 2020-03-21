# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'skrill_payout/version'

Gem::Specification.new do |spec|
  spec.name          = "skrill_payout"
  spec.version       = SkrillPayout::VERSION
  spec.authors       = ["techlegends","macejmic"]
  spec.email         = ["jeremy@techlegends.com"]
  spec.description   = %q{Skrill payout}
  spec.summary       = %q{Skrill payout}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'webmock'

  spec.add_dependency('faraday')
  spec.add_dependency('xml-simple')

end
