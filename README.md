# Crowdsurge Ticketapp

1. run bundle install
2. rake db:create
3. sign in with username: "guest123" and password: "password"

That should be all! The seed file is already populated with tickets and the rspec tests can be run with rake.

#### Other Documentation: 
* The app is a fairly barebones RESTful rails app. 
* Users can sign up or sign in and create tickets to events. 
* The only additional gems I added were rspec and capybara for testing. 
* Delete buttons and edit links only appear for OP. 
