$:.push File.expand_path("../lib", __FILE__)
require 'influential/version'

Gem::Specification.new do |s|
  s.name        = 'gem-graph'
  s.version     = GemGraph::VERSION
  s.date        = Date.today.to_s
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['John Murray']
  s.email       = ['me@johnmurray.io']
  s.homepage    = 'http://github.com/johnmurray/gem-graph'
  s.summary     = %q{A search for the most influential gems.}
  s.description = %q{A search for the most influential gems by analyzing current
                     gem dependencies and visualizing the results from varying
                     perspectives.}
  s.licenses    = ['MIT']

  s.add_dependency 'rake', '~> 0.9.2.0'
  
  s.add_development_dependency 'pry',   '~> 0.9.11'
  s.add_development_dependency 'rspec', '~> 2.12.0'
  
  s.files         = `git ls-files`.split("\n") - ['.gitignore', '.rspec', '.travis.yml']
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f) }
  s.require_paths = ['lib']
end
