require ::File.expand_path('../spec_helper.rb', __FILE__)

describe LACES::Graph do

  before(:all) do
    Graph.publicize_methods do
      @graph = Graph.new
      @graph.collect_index
    end
  end

  it "should not download the index until is is needed (live-test)" do
    Graph.publicize_methods do
      graph = Graph.new
      graph.index.should be_nil
      graph.collect_index
      graph.index.length.should > 0
    end
  end

  it "should create node collection from index" do
    @graph.nodes.count.should == @graph.index.count
  end

  it "should populate each node with some basic information" do
    random_index = @graph.index.sort_by { rand }
    3.times do |i|
      g = random_index[i]
      gem_name = g.first
      gem_version = g[1].version
      @graph.nodes[gem_name].should_not == nil
      @graph.nodes[gem_name].gem_spec.should_not == nil
    end
  end

  it "should collect requirements for any given gem" do
    Graph.publicize_methods do
      random_index = @graph.index.sort_by { rand }
      3.times do |i|
        g = random_index[i]
        reqs = @graph.collect_requirements(g.first, g[1].version)
        reqs.should_not == nil
        reqs.dependencies.should_not == nil
      end
    end
  end

  it "should build a dependency graph when collecting requirements" do
    Graph.publicize_methods do
      random_index = @graph.index.sort_by { rand }
      3.times do |i|
        g = random_index[i]
        reqs = @graph.collect_requirements(g.first, g[1].version)
        @graph.add_dependencies(g.first, reqs)

        reqs.dependencies.each do |dep|
          @graph.nodes[g.first].dependencies.should include(@graph.nodes[dep.name])
          @graph.nodes[dep.name].references.should include(@graph.nodes[g.first])
        end
      end
    end
  end

end
