# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'devise_ott/version'

Gem::Specification.new do |spec|
  spec.name          = 'devise_ott'
  spec.version       = DeviseOtt::VERSION
  spec.authors       = ['Iuri Gagnidze']
  spec.email         = ['igagnidz@gmail.com']
  spec.description   = %q{Adds one time token authentication to devise}
  spec.summary       = %q{Adds one time token authentication to devise}
  spec.homepage      = 'https://github.com/igagnidz/devise_ott'
  spec.license       = 'MIT License'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  # Dont sing yet.
  # spec.cert_chain  = ['certs/igagnidz.pem']
  # spec.signing_key = File.expand_path('~/.ssh/gem-private_key.pem') if $0 =~ /gem\z/

  spec.add_dependency 'devise'
  spec.add_dependency 'redis'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rails'
  spec.add_development_dependency 'minitest-rails'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'coveralls'
end
