#encoding: utf-8

Gem::Specification.new do |gem|
  gem.name        = "not_my_job"
  gem.version     = "0.0.1"
  gem.summary     = "Provides a delegate class method to easily expose contained object's methods as your own."
  gem.description = "Provides a delegate class method to easily expose contained object's methods as your own. If an optional code block is specified, then that will be run and its result returned when the delegate object is nil."
  gem.author      = "Alfredo Ramírez"
  gem.email       = "alfredormz@gmail.com"
  gem.homepage    = 'http://github.com/alfredormz/not_my_job'

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.add_development_dependency "rspec"
end
