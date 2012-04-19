# -*- encoding: utf-8 -*-
Gem::Specification.new do |gem|
  gem.authors       = ["Andriy Yanko"]
  gem.email         = ["andriy.yanko@gmail.com"]
  gem.description   = %q{HTTP persistent connection support for ActiveResource}
  gem.summary       = %q{HTTP persistent connection support for ActiveResource}
  gem.homepage      = "https://github.com/railsware/activeresource-persistent"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "activeresource-persistent"
  gem.require_paths = ["lib"]
  gem.version       = "0.0.1"

  gem.add_runtime_dependency 'net-http-persistent', '>=2.5'
  gem.add_runtime_dependency 'activeresource', '>=2.3.0'
end
