$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'formgen/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'formgen'
  s.version     = Formgen::VERSION
  s.authors     = ['Philipp Hirsch']
  s.email       = ['philipp.hirsch@metaminded.com']
  s.homepage    = ''
  s.summary     = 'Form generator for mouse users'
  s.description = 'Build your own forms and let others answer them'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 4.1'
  s.add_dependency 'simple_form', '~> 3.1.0'
  s.add_dependency 'nested_form', '~> 0.3'
  s.add_dependency 'font-awesome-rails', '>= 4.1'
  s.add_dependency 'tabulatr2', '~> 0.9'

  s.add_development_dependency 'codeclimate-test-reporter'
  s.add_development_dependency 'sqlite3'
end
