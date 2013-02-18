require 'enumerator'


module LACES

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
  
end
