# Goals Roadmap
A detaile version of what you will find in the README


## ~~Be Package-able in Gem Form~~

### ~~Why?~~
~~Being package-able in gem form is important to getting your work out there
for people to enjoy. I believe this is an important step to lowering the
barrier to entry.~~

### ~~Work Needed~~
~~Not much actual coding work is needed to make this happen. Everything for
gem packaging is already in place. However, this needs to be kept in mind
at every stage of the development process. Design decisions can (and
probably should) be impacted by this goal.~~

This all really isn't true if we're going to expose a web interface (and most
likely setup a public site) so I'm crossing this one off the list.



## Offer a Platform for Gem Dependency-Analysis and Visualization

### Why?
Although I view this as a research project, I still want to contribute a
useful project back to the Ruby community. For me, this means creating a
platform to perform gem dependency-analysis that can aid core-developers
in making decisions as to what should come in (or out) of the std-lib and
where development effort should be placed. 

### Work Needed
Quite a bit is needed to make this a reality. I think a good model for
this is the FnordMetric project. They create a real-time analytics platform
that is highly configurable via ruby-blocks but still provide enough API
calls to make it downright simple.

Need extensible, flexible configuration model. The current model really
isn't extensible beyond the code written in the gem itself.

Need extensible algorithm model. Currently algorithms are stored within the
gem when they should be defined via some API with ruby-blocks or something
similar.

Need a way to start the project programatically. 



## Function as a Useful Analytics Tool
### Why?
It's not much of a platform if all you can do is generate one static view.
The project must have tools to dynamically view different aspects of the
generated results in an interactive workflow. It must also must be
EXTREMELY simple and intuitive to use. The UI is important to ensure that
not just the hardcore hackers will use it. 

### Work Needed
A TON! Seriously, there is a lot that will need to be done here. This
involves creating a nice UI front-end. I'm going to make is a one-page
JavaScript application. So, I'll need do some mocking and determine what
types of features I'd like to incorporate into the front-end. I'm not an
awesome JavaScript hacker so I'll have to bone up on those skills or find
someone to help who's really great.

The biggest decisions to make are:

+ What graphs, views, and/or charts will be useful?
+ What interactive tools will provide the most value when deriving meaningful
results?


## Provide Semi-Live Results via Continuous Processing
### Why?
Although it will be a lot of fun to create, there is a purpose that I'm trying
to get at here. Like I have iterated many times in this document, I am striving
to build a tool. A useful tool that will be used and enjoyed by many. To ensure
this, I have to make sure that the tool and UI front-end are running as some
type of dedicated web site/app. To ensure that the tool is of most use, it must
have up-to-date information. This means that I must define a way to 
continuously collect and process new data and update the information used for
tool. 

### Work Needed
Need to define some type of durable storage for the processed data. This will
be required if I am going to run the collections as some sort of crontab or
scheduled-task. I need a way to diff the new stuff and the old-stuff and update
my graph as needed (in durable storage). 

### Extra Credit
It'd be super-cool if those results/updates could be pushed to any connect
clients. I'm just saying! ;-)   It's not something that is at the top of the
priority list but, it sure would be icing on the cake. 
