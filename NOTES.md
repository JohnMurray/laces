##### Fetching the Index

For a good resource on how the index works (or what it looks like) visit:
http://robots.thoughtbot.com/post/2729333530/fetching-source-index-for-http-rubygems-org
Also discusses how to resolve dependencies for each gem. 
  
  
  
In short, we can use the following URLS to get the information that we need

  * `http://rubygems.org/specs.4.8.gz`
  * `http://rubygems.org/quick/Marshal.4.8/[gem-name]-[gem-version].gemspec.rz`

Both of these will yield files that can be marshalled into Ruby




##### Computing the Index

Below contains the pseudo-code for building the dependency graph from the
index (primary indexes only):

    nodes = new Array
    gem_list = download-gem-index(remote_server)
    gem_list.each do |gem|
      nodes << new Node(gem.name)
    end
    gem_list.each do |gem|
      gem.dependencies.each do |dependency|
        nodes[dependency].references << nodes[gem.name]
      end
    end
