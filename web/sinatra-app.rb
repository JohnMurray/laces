require 'sinatra'
require './config/sinatra-config.rb'


get '/' do
  send_file(File.join(settings.public, 'index.html'))
end

##----
## Require all of the endpoints (in the endpoints folder)
##----
$: << settings.endpoint_root
Dir[File.join(settings.endpoint_root, "*.rb")].each do |f|
  require File.basename(f, File.extname(f))
end
