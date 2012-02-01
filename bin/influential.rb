require 'rake'

namespace :build do

  desc ''
  task :clean do
  end

  desc ''
  task :cache do
  end

end

task :default => ['build:clean']

Rake.application.init('influential')
Rake.application.top_level
