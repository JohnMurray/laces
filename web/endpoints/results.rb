##----
## File endpoints/hello.rb
## 
##   This file contains all endpoints for /results/*.
##----

get '/results' do
    haml :results
end
