require_relative 'graph_cache/json'
require_relative 'graph_cache/marshal'
require_relative 'graph_cache/mysql'


module Laces
  module GraphCache
    # Public: Initialize the correct cache-class based on the configuration
    # settings and then return the data from the cache.
    #
    # Returns a NodeCollection from the cache or nil.
    def self.get_cache
      cache = load_cache_class
      cache.get
    end

    def self.store_cache
      # dynamically get all classes in the GraphCache namespace
      # initialize correct-class cache based on settings
      # store the cache
    end

    private

    # Public: 
    def self.load_cache_class
      cache_class = Laces::settings.backend_cache_store

      unless GraphCache.constants.include? cache_class
        raise "ERROR::Invalid backend cache store defined #{cache_class}"
      end
      
      cache = GraphCache.const_get(cache_class)
    end
  end
end