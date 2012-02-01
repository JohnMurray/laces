# Fetching the Index

For a good resource on how the index works (or what it looks like) visit:
http://robots.thoughtbot.com/post/2729333530/fetching-source-index-for-http-rubygems-org
Also discusses how to resolve dependencies for each gem. 
  
  
  
In short, we can use the following URLS to get the information that we need

  * `http://rubygems.org/specs.4.8.gz`
  * `http://rubygems.org/quick/Marshal.4.8/[gem-name]-[gem-version].gemspec.rz`

Both of these will yield files that can be marshalled into Ruby




# Computing the Index

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
        nodes[gem.name].dependencies << nodes[dependency]
      end
    end

---

# Computing the Primary-Link Weights

This is really already done for us. Primary-links indicate direct dependency
relationships. This is already represented by the basic index. We only need
to count the references to get each node's weight. 

---

# Computing the Secondary-Link Weights

Secondary links indicate references of references. In this case, it might show
lower-level gems that are used as a base in many projects. For example,
`Mongoid` might be a popular gem and could be found as a dependency in a lot of
projects. However, if we are looking at secondary dependencies, then we might
notice that `bson` or `bson_ext` are even more common. Essentially, this will
show us one-level deeper in the tree where the tree might look like:

    |--rails
       |--mongoid
          |--bson
          |--bson_ext
       |--awesome-sauce-gem
          |--event-machine
          |--bson
       |--rake
       |--etc...

I'm not actually sure this will yield any interesting results but, I'm still
interested to find out. 

---

# Std Lib Analysis

I'd like to do a static-analysis of each gem to see what libraries and classes
from the Std Lib are being used. I think it would be interesting to compare
some Std Lib packages to some popular gems out there. 
This could lead to some interesting findings suggesting that some libraries
should come out of Std Lib and some gems should be included (or at least
focused upon for performance). 

This is going to be much harder than what I am currently doing as I will need
to obtain the source for each gem and run it through some type of parser to get
the AST at which point I would walk through it and determine what is being used.
I'll also need to identify all of the classes/modules that come from the Std
Lib some way or another. 


---

# CLI Usage

The program will be callable from the command line via a gem-binary using rake
in the following formats

    influential build:cache              # just cache the dependency graph
    influential build:alg:primary        # process primary link alg
    influential build:alg:secondary      # process secondary link alg
    influential build:alg:std_lib        # process std_lib alg

Note that the algorithms will be dynamically loaded into the project such that
the algorithms will be pluggable. 




