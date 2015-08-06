$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'pg_query/version'

Gem::Specification.new do |s|
  s.name        = 'pg_query'
  s.version     = PgQuery::VERSION

  s.summary     = 'PostgreSQL query parsing and normalization library'
  s.description = 'Parses SQL queries using a copy of the PostgreSQL server query parser'
  s.author      = 'Lukas Fittl'
  s.email       = 'lukas@fittl.com'
  s.license     = 'BSD-3-Clause'
  s.homepage    = 'http://github.com/pganalyze/pg_query'

  s.extensions = %w(ext/pg_query/extconf.rb)

  s.files       = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }

  s.add_development_dependency 'rake-compiler', '~> 0'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rubocop-rspec'

  s.add_runtime_dependency 'json', '~> 1.8'
end
