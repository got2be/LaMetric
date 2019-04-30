Gem::Specification.new do |gem|
  gem.name        = 'la_metric'
  gem.version     = '0.0.1'
  gem.date        = '2019-04-30'
  gem.summary     = 'LaMetric'
  gem.description = 'A gem for LaMetric smart clock'
  gem.authors     = ['Ilia Kasianenko']
  gem.email       = 'i.kasianenko@gmail.com'
  gem.files       = `git ls-files | grep -Ev '^(spec)'`.split("\n")
  gem.homepage    = 'https://github.com/got2be/LaMetric'
  gem.license     = 'MIT'
  gem.required_ruby_version = '>= 2.5.0'
end
