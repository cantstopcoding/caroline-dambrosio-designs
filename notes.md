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


User has_many :items 
Item belongs_to :user 

Category:
- name
- has_many :posts
- has_many :users, through :posts

rails g resource Post title content:text user:belongs_to category:belongs_to --no-test-framework