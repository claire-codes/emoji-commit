# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'emoji-commit-version'

Gem::Specification.new do |spec|
  spec.name          = 'emoji-commit'
  spec.version       = EmojiCommit::VERSION
  spec.authors       = ['Claire Parker']
  spec.email         = ['claire.parker87@gmail.com']

  spec.summary       = %q(Adds an emoji to your commit message)
  spec.description   = %q(Prefixes Git commit messages with a random GitHub-friendly emoji.)
  spec.homepage      = 'https://github.com/claireparker/emoji-commit'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = ['emoji']
  spec.require_paths = ['lib']

  spec.add_dependency 'thor'
  spec.add_dependency 'json', '~> 1.8.1'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
end
