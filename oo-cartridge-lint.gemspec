Gem::Specification.new do |s|

  s.name        = 'oo-cartridge-lint'
  s.version     = '0.1'
  s.summary     = "OpenShift Cartridge lint"
  s.description = "Validate the OpenShift cartridge"
  s.authors     = ["Michal Fojtik"]
  s.email       = ['mfojtik@redhat.com']
  s.bindir      = 'bin'
  s.executables  = Dir['bin/*'].map{ |f| File.basename(f) }
  s.license     = 'ASL 2.0'
  s.files       = Dir['lib/**/*.rb'] + Dir['bin/*'] + Dir['schema/*'] + Dir['tests'] + ['README.md']
  s.test_files  = Dir.glob('tests/**/*_test.rb')
  s.require_path = 'lib'
  s.homepage    = 'https://rubygems.org/gems/oo-cartridge-lint'

  s.add_runtime_dependency 'kwalify', '>= 0.7.2'
  s.add_runtime_dependency 'commander'
end
