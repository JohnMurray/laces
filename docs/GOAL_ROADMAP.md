# Goals Roadmap
A detaile version of what you will find in the README


## Be Package-able in Gem Form

### Why?
Being package-able in gem form is important to getting your work out there
for people to enjoy. I believe this is an important step to lowering the
barrier to entry.

### Work Needed
Not much actual coding work is needed to make this happen. Everything for
gem packaging is already in place. However, this needs to be kept in mind
at every stage of the development process. Design decisions can (and
probably should) be impacted by this goal.



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
### Work Needed



## Provide Semi-Live Results via Continuous Processing
### Why?
### Work Needed
