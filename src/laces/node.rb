

module Laces

  ##----
  ## Node to be used in the graph. This contains all the links to other nodes
  ## and also holds meta-data for each node.
  ##
  ## It may be important to note that a node is representative of a Ruby gem
  ## and all of it's data and links are relevant to the gem meta-data and
  ## dependencies.
  ## 
  ## Bi-Directional Links
  ##   The nodes link to each other bi-directionally such that if gem A depends
  ##   on gem B and C, then those gems will be referenced within gem A's
  ##   'dependencies' array. However, if gem D and E are both dependent upon
  ##   A, then references to D and E will be found in A's references array.
  ##----
  class Node
    
    attr_accessor :name, :dependencies, :references, 
                  :weight, :gem_spec

    def initialize(opts = {})
      options = {
        :name         => nil,
        :dependencies => [],  # this node's dependencies
        :references   => [],  # which gems list me (this gem) as a dependency
        :weight       => 0,
        :gem_spec     => nil
      }.merge opts
      begin
        options.each {|k,v| send("#{k}=", v)}
      rescue NoMethodError => e
        raise "Unsupported Node option: #{k}"
      end
    end

  end

end
