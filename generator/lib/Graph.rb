require 'uri'
require 'net/http'
require 'open-uri'

$: << File.dirname(__FILE__)
require 'Node'
require 'NodeCollection'


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

end
