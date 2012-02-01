require 'rake'

$: << ::File.expand_path('../../lib', __FILE__)
require 'influential/graph'

include INFLUENTIAL

namespace :build do

  # Great to add as a dependency of any algorithms tasks.
  desc 'Build the dependency graph cache'
  task :cache do
    graph = Graph.new
    graph.build
    
  end

end

task :default => ['build:clean']

Rake.application.init('influential')
Rake.application.top_level
