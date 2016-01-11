# Zapskills
zapskills.herokuapp.com

Skills Trading platform that connects users for a trade of knowledge

User manual located at https://drive.google.com/file/d/0B0cYwXySqKkbQUUyaUxfN3Q5d28/view?usp=sharing

## Setup

### RVM

Clone repository onto a desired location on your machine.

The application uses Ruby on Rails. We use RVM to manage our Rubies and gemsets. Go ahead and install rvm at [rvm.io](https://rvm.io).

Once you've installed RVM, run 

`$ rvm install 2.2.0` 

to install ruby 2.2.0, Then run 

`$ rvm gemset create zapskills`  

to create a gemset named zapskills. You'll see in the root of the app directory the two files names .ruby-gemset and .ruby-version expect these configurations. 

Once RVM and the gemset is set up, run `$ bundle install` to download all gems. 

### Database

Ensure that the settings in database.yml match your local mysql settings. 

`$ rake db:create` to create the databases.

`$ rake db:setup` to set up the schemas and seed the databases.

### Running

Run `$ rails s` to turn on your local server and see the webapp at localhost:3000. 

Alternatively, visit zapskills.herokuapp.com to see the app in production, which is a clone of the master branch. 

### Testing

To run all tests: `$ bundle exec rspec`




