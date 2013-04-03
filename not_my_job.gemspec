#encoding: utf-8

Gem::Specification.new do |gem|
  gem.name        = "not_my_job"
  gem.version     = "0.0.3"
  gem.summary     = "Provides a delegate class method to easily expose contained object's methods as your own."
  gem.description = "Provides a delegate class method to easily expose contained object's methods as your own. If the delegate object is nil, there are several options: If no block is provided, it will raise a NoMethodError exception; if the optional code block is specified you may return an alternate value, or to take some arbitrary action."
  gem.author      = "Alfredo Ramírez"
  gem.email       = "alfredormz@gmail.com"
  gem.homepage    = 'http://github.com/alfredormz/not_my_job'

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.add_development_dependency "rspec"
end
