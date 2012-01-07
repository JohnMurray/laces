require 'uri'
require 'net/http'
require 'open-uri'
require 'enumerator'


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

  ## Only look for gems on this platform
  PLATFORM = "ruby"
  MARSHAL_VERSION = "#{Marshal::MAJOR_VERSION}.#{Marshal::MINOR_VERSION}"


  ##----
  ## Helps obtain all of the necessary indexes and builds a simple graph of
  ## gems; containing only the primary links and all gathered meta-data.
  ##----
  class Graph
  
    attr_accessor :index, :nodes

    def initialize
      @index_uri = URI.parse(
        "http://production.s3.rubygems.org/latest_specs.#{MARSHAL_VERSION}.gz")
      @dep_uri_template = "http://rubygems.org/quick/Marshal.4.8/%s-%s.gemspec.rz"
      collect_index
    end


    def build
      @nodes = NodeCollection.new
      index.each do |gem|
        @nodes << (Node.new :name => gem.first)
      end
      index.each do |gem|
        reqs = collect_requirements(gem.first, gem[1].version)
        reqs.dependencies.each do |dep|
          @nodes[gem.first].dependencies << @nodes[dep.name]
          @nodes[dep.name].references    << @nodes[gem.first]
        end
      end
    end
  
  
    private
    def collect_index
      index_gz = open @index_uri
      index_bin = Gem.gunzip index_gz.read
      begin
        @index = Marshal.load index_bin
        @index.reject! {|i| i.last != PLATFORM }
      rescue => e
        puts "Unable to marshal full index"
        puts "Error: #{e.message}"
        exit 1
      end
    end

    def collect_requirements(gem_name, gem_version)
      req_uri = URI.parse(@dep_uri_template % [gem_name, gem_version])
      req_gz = open req_uri
      req_bin = Gem.inflate req_gz.read
      reqs = Marshal.load req_bin
    end
  
  end


  ##----
  ## A simple collection for holding nodes. I wanted something that would
  ## offer me a cleaner implementation in the Graph class.
  ##----
  class NodeCollection
   
    include Enumerable

    def initialize
      @collection = {}
    end

    def << node
      @collection[node.name.to_sym] = node
    end

    def [] node_name
      @collection[node_name.to_sym]
    end

    def count
      @collection.count
    end

    def each
      @collection.each {|k,v| yield v }
    end

    alias :length :count
    alias :size   :count
  end
  
  
  ##----
  ## Node to be used in the graph. This contains all the links to other nodes
  ## and also holds meta-data for each node (gem).
  ##----
  class Node
    
    attr_accessor :name, :dependencies, :references, 
                  :weight, :gem_spec, :requirements

    def initialize(opts = {})
      options = {
        :name         => nil,
        :dependencies => [],  #this nodes dependencies
        :references   => [],  #which gems list me (this gem) as a dependency
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
