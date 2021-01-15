# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- [x] Use ActiveRecord for storing information in a database
  - Created three tables in total, a user and post table, and a join table 
- [x] Include more than one model class (e.g. User, Post, Category)
  - Included a User, Post and follow modal
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
  - The user modal has many posts and followers/followees 
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
  - The Post modal belongs to the user Modal and follow model also belongs to the user modal 
- [x] Include user accounts with unique login attribute (username or email)
  - The user can log in with a username and password, the username is unique to each user 
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating, and Destroying
  - Each user can create a new Blog, and also can edit/delete said blog, no other user but the owner of the blog can manipulate it   
- [x] Ensure that users can't modify content created by other users
  - Only if logged in and if the current user's id matches with the post's id then the user will have access to edit their posts
- [x] Include user input validations
  - Added validation is the User modal so that if it tries to save nil information in the controller it will return as false  
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
  - Used flash messages to show the user that their action has correctly occurred 
- [x] Your README.md includes a short description, install instructions, a contributors guide, and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
