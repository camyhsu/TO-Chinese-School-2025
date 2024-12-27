# Thousand Oaks Chinese School Application

This is the student information application used by Thousand Oaks Chinese School, 
updated for Rails 8 in 2025.  The original application is at 
[GitHub TO-Chinese-School](https://github.com/camyhsu/TO-Chinese-School/tree/master) 
and was using Rails 3.2 before the update.

The main goal of the update is to bring the code up to the latest version 
of Rails running on the recent Ubuntu 24.04 LTS so that we can get the 
security patches and keep it secure.  The original app does not have test 
coverages and is too old and painful to go through the version by version 
upgrade train.  Hence, the approach taken here is to re-create relevant 
functionalities in a new Rails 8 skeleton, using updated syntax and such.

There is generally a lack of resources to perform regular maintenances and
upgrades for a volunteer organization like a local Chinese School.  
Therefore, we will be using default Rails patterns as much as possible so 
that future maintenance is less complicated (i.e., no fancy stuffs).  The 
main deviation in the basic setup from a simple Rails tutorial is that 
the application runs on PostgreSQL database and is using a single server 
setup (i.e., no docker nor kamal).  This is due to the historical structure 
the application had been deployed as a simple, low traffic browser app.
