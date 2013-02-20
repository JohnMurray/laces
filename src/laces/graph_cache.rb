require_relative 'graph_cache/json'
require_relative 'graph_cache/marshal'
require_relative 'graph_cache/mysql'


module Laces
    module GraphCache
        def self.get_cache
            # dynamically get all classes in the GraphCache namespace
            classes = GraphCache.constants.select { |c| 
                GraphCache.const_get(c).is_a? Class
            }
            # initialize correct-class cache based on settings
            
            
            # load and return cache
        end

        def self.store_cache
            # dynamically get all classes in the GraphCache namespace
            # initialize correct-class cache based on settings
            # store the cache
        end
    end
end