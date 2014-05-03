class User < ActiveRecord::Base 
	has_many :posts
	has_many :comments
	has_many :relationships

end

class Post < ActiveRecord::Base 
	belongs_to :user
  
  validates :title, presence: true, length: {minimum: 3}
  validates :body, presence: true
end

class Relationship < ActiveRecord::Base 
	belongs_to :user
end 

class Comment < ActiveRecord::Base 
	belongs_to :user
	belongs_to :post 
end 