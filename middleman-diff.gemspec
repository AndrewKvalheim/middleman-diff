$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |gem|
  gem.name     = 'middleman-diff'
  gem.version  = '0.0.1'
  gem.platform = Gem::Platform::RUBY
  gem.required_ruby_version = '~> 2.1'
  gem.license  = 'MIT'
  gem.authors  = ['Andrew Kvalheim']
  gem.email    = ['Andrew@Kvalhe.im']
  gem.homepage = 'https://github.com/AndrewKvalheim/middleman-diff'
  gem.summary  = "Preview what's changed in your Middleman build."

  gem.files         = `git ls-files -z`.split("\0")
  gem.test_files    = gem.files.grep(/^(features|fixtures)\//)
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'middleman-core', '~> 3.3'
end
