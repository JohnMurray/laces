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

    # Public: Given some object, store the object via the loaded cache-store
    #
    # Returns nothing
    def self.store(obj)
      cache = load_cache_class
      cache.store(obj)
    end

    # Public: Run any setup tasks that are required for the configured cache
    # class
    #
    # Returns nothing
    def self.init
      cache = load_cache_class
      cache.init
    end

    private

    # Private: Load the cache-class that is defined within this module and
    # is set within the configs
    def self.load_cache_class
      cache_class = Laces::settings.backend_cache_store

      unless GraphCache.constants.include? cache_class
        raise "ERROR::Invalid backend cache store defined #{cache_class}"
      end
      
      @cache ||= GraphCache.const_get(cache_class)
    end
  end
end