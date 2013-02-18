

##----
## Contains configuration for the portion of the project responsible
## for collecting and processing the dependency information.
##----
module LACES
  
  ##
  ##  Program Meta-Data
  ##
  set :author, 'John Murray <me AT johnmurray.io>'
  set :version, '0.0.1'


  ##
  ## Directory Settings
  ##
  set :root_dir, File.expand_path(File.join(
               File.dirname(__FILE__),
               '..'))
  set :src_dir,  File.join(settings.root_dir, 'src')
  set :algs_dir, File.join(settings.lib_dir, 'algs')
end
