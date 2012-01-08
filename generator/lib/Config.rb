

##----
## Contains configuration for the portion of the project responsible
## for collecting and processing the dependency information.
##----
module INFLUENTIAL
  set :root_dir, File.expand_path(File.join(
               File.dirname(__FILE__),
               '..'))
  set :lib_dir,  File.join(settings.root_dir, 'lib')
  set :algs_dir, File.join(settings.lib_dir, 'algs')
end
