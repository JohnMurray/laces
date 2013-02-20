require 'uri'
require 'net/http'
require 'open-uri'

require_relative 'node'
require_relative 'node_collection'


##----
## Class neccessary to build a Dependency Graph of the gems at RubyGems.org.
## 
## Algorithm Notes:
##   The algorithm only analyzes the current gem versions. This is to keep
##   things simple for my first pass at this. This means that if a project
##   links to an older gem, the newest version of that gem will get credit
##   for that link.
## 
## 
##----
module Laces

  ## Only look for gems on this platform
  PLATFORM = "ruby"
  MARSHAL_VERSION = "#{Marshal::MAJOR_VERSION}.#{Marshal::MINOR_VERSION}"
  INDEX_URL = "http://production.s3.rubygems.org/latest_specs.#{MARSHAL_VERSION}.gz"
  GEM_METADATA_URL = "http://rubygems.org/quick/Marshal.4.8/%s-%s.gemspec.rz"


  ##----
  ## Helps obtain all of the necessary indexes and builds a simple graph of
  ## gems; containing only the primary links and all gathered meta-data.
  ##
  ## index - The index of gems from rubygems.org stored in a binary format
  ##----
  class Graph
  
    attr_reader :index, :nodes


    # Public: Build up the graph by collecting the index and building a node
    # graph from the results. While some of these tasks
    def build
      collect_index
      init_nodes
      setup_node_dependencies
    end
  
  
    private

    # Private: Download the gem-index from the INDEX_URL and parse out the
    # data. 
    # 
    # The parsed data from the index follows the form of:
    #   
    #   [
    #     [name: String, version: Gem::Version, platform: String]
    #     ...
    #   ]
    #
    # Returns nothing, but populates the @index variable
    def collect_index
      index_gz = open( URI.parse(INDEX_URL) )
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


    # Private: Initialize the node collection with nodes from the index. Do not
    # however, create the actual links between the nodes. That will come later
    # as we must first have all of the nodes in the colleciton to do that.
    #
    # Returns nothing, but sets the @node variable
    def init_nodes
      @nodes = NodeCollection.new
      @index.each do |gem|
        @nodes << Node.new({ 
          :name       => gem.first,
          :gem_spec   => gem
        })
      end
    end


    # Private: Analyze the dpenedencies of the nodes and link them together,
    # thus creating the "graph" vs a loose colleciton of nodes. Each edge
    # in the graph represents a directional dependency relationship.
    def setup_node_dependencies
      @index.each do |gem|
        gem_meta = collect_gem_meta(gem.first, gem[1].version)
        add_dependencies(gem.first, gem_meta)
      end
    end


    # Private: Download the gem's metadata from rubygems.org and unpack/parse
    # it.
    #
    # For example, if we were looking at the Pry gem, then we would get
    # back a list of dependencies containing CodeRay for syntax highlighting.
    #
    # Returns meta-data information regarding the gem in form of
    # Gem::Specification object
    def collect_gem_meta(gem_name, gem_version)
      reqs_uri = URI.parse(GEM_METADATA_URL % [gem_name, gem_version])
      reqs_gz = open( reqs_uri )
      reqs_bin = Gem.inflate reqs_gz.read
      Marshal.load( reqs_bin )
    end


    # Private: Given the gem name and the gem's meta-data, we can now start
    # linking nodes together with directional-dependency links. For each
    # dependency, the dependent is linked to the required gem and the required
    # gem is linked back to the dependent.
    #
    # Returns nothing, but modifies the nodes in the node-collection.
    def add_dependencies(gem_name, gem_meta)
      gem_meta.dependencies.each do |dep|
        @nodes[gem_name].dependencies << @nodes[dep.name] if @nodes[dep.name]
        @nodes[dep.name].references   << @nodes[gem_name] if @nodes[dep.name]
      end
    end
  
  end

end
