require 'uri'
require 'net/http'
require 'open'


##----
## Build a dependency graph based on the index from RubyGems.org
## 
## Algorithm Notes:
##   The algorithm only analyzes the current gem versions. This is to keep
##   things simple for my first pass at this. This means that if a project
##   links to an older gem, the newest version of that gem will get credit
##   for that link.
## 
## 
##----
module INFLUENTIAL

  ##----
  ## Helps obtain all of the necessary indexes and builds a simple graph of
  ## gems; containing only the primary links and all gathered meta-data.
  ##----
  class Graph
  
    def initialize()
      @index_uri = URI.parse "http://production.s3.rubygems.org/latest_specs.4.8.gz"
      @dep_uri_template = "http://rubygems.org/quick/Marshal.4.8/%s-%s.gemspec.rz"
      collect_index
    end


    def build()

    end
  
  
    private
    def collect_index()
      index_gz = open @index_uri
      index_bin = Gem.gunzip index_gz.body
      begin
        @index = Marshal.load index_bin 
      rescue => e
        puts "Unable to marshal full index"
        puts "Error: #{e.message}"
        exit 1
      end
    end

    def collect_requirements(gem_name, gem_version)
      req_uri = URI.parse(@dep_uri_template % [gem_name, gem_version])
      req_gz = open req_uri
      req_bin = Gem.inflate req_gz
      reqs = Marshal.load req_bin
    end
  
  end
  
  
  ##----
  ## Node to be used in the graph. This contains all the links to other nodes
  ## and also holds meta-data for each node (gem).
  ##----
  class Node
    
    attr_accessor :name, :dependencies, :references, :weight, :gem_spec, :requirements

    def initialize(opts = {})
      options = {
        :name         => nil,
        :dependencies => [],
        :references   => [],
        :weight       => 0,
        :gem_spec     => nil,
        :requirements => []
      }.merge opts
      begin
        options.each {|k,v| send("#{k}=", v)}
      rescue NoMethodError => e
      end
    end

  end

end
