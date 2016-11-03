# frozen_string_literal: true
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'movlog/version'

Gem::Specification.new do |s|
  s.name        =  'movlog'
  s.version     =  Movlog::VERSION

  s.summary     =  'Gets movie content from omdb'
  s.description =  'find movie locations, routes and rooms'
  s.authors     =  ['Andy Wen', 'Nick Huang', 'Aditya Utama Wijaya']
  s.email       =  ['a409052003@gmail.com', 'z58085111@gmail.com', '
adityautamawijaya@gmail.com']

  s.files       =  `git ls-files`.split("\n")
  s.test_files  =  `git ls-files -- spec/*`.split("\n")
  s.executables << 'movlog'

  s.add_runtime_dependency 'http', '~> 2.0'
  s.add_runtime_dependency 'nokogiri', '~> 1.6','>= 1.6.8.1'

  s.add_development_dependency 'minitest', '~> 5.9'
  s.add_development_dependency 'minitest-rg', '~> 5.2'
  s.add_development_dependency 'rake', '~> 11.3'
  s.add_development_dependency 'vcr', '~> 3.0'
  s.add_development_dependency 'webmock', '~> 2.1'
  s.add_development_dependency 'simplecov', '~> 0.12'
  s.add_development_dependency 'flog', '~> 4.4'
  s.add_development_dependency 'flay', '~> 2.8'
  s.add_development_dependency 'rubocop', '~> 0.42'

  s.homepage    =  'https://github.com/soafloggers/movlog'
  s.license     =  'MIT'
end
