# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
    []gem required, controllers inherit from Sinatra::Base
- [x] Use ActiveRecord for storing information in a database
    []gem required, models inherit from ActiveRecord::Base
- [x] Include more than one model class (list of model class names e.g. User, Post, Category)
    []models: User, Plant, Location, PlantLocation
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Posts)
    []User has_many Locations, etc.
- [x] Include user accounts
    []Users have accounts with usernames and passwords
- [x] Ensure that users can't modify content created by other users
    []Cannot view other users' homepage, plants, locations, passwords
- [x] Include user input validations
    []new plant/location cannot start with space, must have name; username restricted to alphanumeric
- [x] Display validation failures to user with error message (example form URL e.g. /posts/new)
    []error messages on all incorrect inputs and flash messages on disallowed routes
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
    []description, install, contributors guide, license
Confirm
- [x] You have a large number of small Git commits
    []yes
- [x] Your commit messages are meaningful
    []yes
- [x] You made the changes in a commit that relate to the commit message
    []yes
- [x] You don't include changes in a commit that aren't related to the commit message
    []I find this difficult sometimes, but generally yes
