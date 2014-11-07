$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |gem|
  gem.name     = 'middleman-diff'
  gem.version  = '0.0.1'
  gem.platform = Gem::Platform::RUBY

  gem.files         = `git ls-files -z`.split("\0")
  gem.test_files    = gem.files.grep(/^(test|spec|fixtures)\//)
  gem.executables   = gem.files.grep(/^bin\//).map { |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'middleman-core', '>= 3.3.6'
end
