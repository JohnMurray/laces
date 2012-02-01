

module INFLUENTIAL

  ##----
  ## Node to be used in the graph. This contains all the links to other nodes
  ## and also holds meta-data for each node (gem).
  ##----
  class Node
    
    attr_accessor :name, :dependencies, :references, 
                  :weight, :gem_spec

    def initialize(opts = {})
      options = {
        :name         => nil,
        :dependencies => [],  #this nodes dependencies
        :references   => [],  #which gems list me (this gem) as a dependency
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
