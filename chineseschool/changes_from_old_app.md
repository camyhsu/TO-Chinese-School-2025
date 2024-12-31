## Changes from the previous version of this application

### Overview
There are functional differences between this new version of application and
the previous version on Rails 3.2 at 
[GitHub TO-Chinese-School](https://github.com/camyhsu/TO-Chinese-School/tree/master) .  Some old existing functionalities are
no longer used as the school evolves over time, so the application code for
these outdated functionalities would not be reproduced in this new version,
although the old data are kept in the database for historical records.  There
are also adjustments or new functionalities (such as new or updated model
validations) being added to the new version as functionalities are 
re-created.  The changes are documented below in sections as the new version 
is written.

Only functionality changes are documented.  There are numerous technical 
syntax or method usage changes which are just a natural part of moving from 
the old framework (Ruby 1.9.3 / Rails 3.2) to the new (Ruby 3.3.6 / 
Rails 8.0.1) and these won't be documented.

Note that this document likely won't cover additional evolutions of this 
version in the future after the initial re-creation is completed.  The new 
changes should be visible in the commit history of this git repository 
anyway.  If there is a need to create a change log going forward, it should 
be done separately.

### Models

#### Models not in the new version
The following models are no longer used and not re-created in the new version of this application:
* InPersonRegistrationTransaction
* InstructorAssignmentHistory
* JerseyNumber

#### Address
* Phone number validations have been updated to a more precise 10 digit 
validation and include cell phone in the validation.
* Zipcode validations have been updated to a more precise 5 digit validation.
* Email format validation is added, and a before validation callback will 
downcase the email.

#### GatewayTransaction
* Validations are added for credit card type and last digits, as well as the 
amount.

#### InstructorAssignment
* The "no overlapping assignment period" validation has been removed (not 
re-created) since it was not useful in the past and is complicated.
* Role validation has been updated to a more precise inclusion check.

#### Person
* Gender validation has been updated to a more precise inclusion check.
