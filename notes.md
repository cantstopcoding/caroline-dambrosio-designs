To Do:
- [x] check on that view page
- [x] take care of deleting items
- [x] add validations
- [x] add more scope methods
- work on authorization
- [x]continue to add on to form displays of validation errors
- check to see if I'm utilizing has many through relationships
- [x] add more scope methods
- refactor more
- [x] fix omniauth
- [x] check to see if i have at least 2 has_many through relationships and if it is working
- add categories resource
- add image for users

potential questions -



Caroline Models-

Caroline would be an admin

User:
- has_many :posts
- has_many :items
- has_many :item_posts, through :items
- has_many :categories, through :posts
- username
- first_name
- last_name
- email 
- password_digest  

Post: *join table joining categories and users
- belongs_to :user
- has_many :items
- has_many :users, through :items
- belongs_to :category 
- title
- content:text

Item: *join table joining users and posts
- belongs_to :users
- belongs_to :posts
- name
- image
- price
- description:text

rails g resource Item name image price:integer description:text user:belongs_to post:belongs_to --no-test-framework

User has_many :items 
Item belongs_to :user 

Category:
- name
- has_many :posts
- has_many :users, through :posts


Nested Routes:

/users
/users/:id/posts
/users/:id/items(maybe)

/posts
/posts/:id/items

/comments
















ChefModels- 

User:
- has_many :posts
-  has_many :recipes
- has_many :commented_recipes, through :comments


Recipes:
- belongs_to :user
- has_many :comments
- has_many :users, through :comments
- title
- ingredients
- instructions
- contens
- description

Comment:
- belongs_to :users
- belongs_to :recipe

Category: 
- name
- has_many :recipes
- has_many :users, through :recipes
