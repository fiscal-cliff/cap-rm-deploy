# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cap/rm/deploy/version'

Gem::Specification.new do |spec|
  spec.name          = "cap-rm-deploy"
  spec.version       = Cap::Rm::Deploy::VERSION
  spec.authors       = ["Evgeniy Lukovsky"]
  spec.email         = [""]

  spec.summary       = %q{Capistrano redmine integration plugin}
  spec.description   = %q{Capistrano plugin that allows you to update redmine issues automagically}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"
  spec.post_install_message = "Please refer documentation in order to setup an initializer"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", ">= 10.0"
  spec.add_runtime_dependency 'activeresource', '~> 4.0.0', '>= 4.0.0'
  spec.add_dependency 'capistrano', '>= 3.0'
end
