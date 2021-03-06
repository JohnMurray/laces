# Influential

[ ![Build status - Travis-ci][1] ][2]
[ ![Dependency Status][4] ][5]

ThisPublic projec the ongoing work for a research project that I am
working on to find the most influential Gem in the Ruby-verse. Right now
there are several directions that the research could take and many avenues
that could be explored in terms of what this research will mean and what
information I would like to be able to derive from the data.



## Goals

To help stay on track in the development process, I've identified some
goals that I'd like this project to achieve and maintain. They are as
follows:

+ ~~Be package-able in Gem form~~
+ Offer a platform for gem dependency-analysis and visualization
+ Function as a useful analytics tool
+ Provide semi-live results via continuous processing via a web-interface

For more explanation about each goal, see `docs/GOALS_ROADMAP.md`


## Contributing
To contribute, just fork the project and submit your additions via a pull-
request. Make sure to checkout the **wishlist** to see what is on the
agenda or checkout the [Trello][3].

Extra resources:

+ PM Software: https://trello.com/b/mjmQlvNF
+ Main GitHub Repo: https://github.com/JohnMurray/influential


## Whishlist

+ Option to cache dependency-graph and use that
+ ~~CLI runner via rake tasks~~
+ ~~Add additional meta-data to node objects when parsing~~
+ Implement primary-link algorithm (weighting)
+ Implement secondary-link algorithm (weighting)
+ Come up with a more flexible configuration model
+ Pry console for debugging/interacting with graph model and algorithms


  [1]: https://secure.travis-ci.org/JohnMurray/gem-graph.png
  [2]: https://travis-ci.org/JohnMurray/gem-graph
  [3]: https://trello.com/b/mjmQlvNF
  [4]: https://gemnasium.com/JohnMurray/influential.png
  [5]: https://gemnasium.com/JohnMurray/influential
