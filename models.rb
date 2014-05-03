class User < ActiveRecord::Base 
	has_many :posts
	has_many :comments
	has_many :relationships

=begin
	attr_accessor :errors

	def valid?
		unless first_name_valid? && last_name_valid? && email_valid? && username_valid? && password_valid?
			return false
		end		
	end

	def first_name_valid? 
		if self.first_name.to_s.empty?
			@errors[first_name] = "First name field cannot be blank."
			return false
		end
	end 

	def last_name_valid? 
		if self.last_name.to_s.empty?
			@errors[last_name] = "Last name field cannot be blank."
			return false
		end
	end 

	def email_valid?
		unless self.email.to_s.match(/\@/)
			@errors[email] = "Email is invalid"
			return false
		end
	end

	def password_valid? 
		unless self.password.to_s.match(/\d/) && self.password.to_s.match(/[[:alpha]]/) && self.password.to_s.length > 5
			@errors[password] = "Password must be at least 6 characters long, and contain at least one letter and one number."
			return false
		end
	end 
=end
end

class Post < ActiveRecord::Base 
	belongs_to :user
  
  validates :title, presence: true, length: {minimum: 3}
  validates :body, presence: true
=begin
	attr_accessor :errors

	def valid?
		unless body_valid? && title_valid?
			return false
		end		
	end

	def body_valid?
		if self.body.to_s.empty?
			@errors[body] = "The blog post must contain a body."
			return false
		end
	end	

	def title_valid?
		if self.title.to_s.empty?
			@errors[title] = "The blog post must contain a title."
			return false
		end
	end			
=end
end

class Relationship < ActiveRecord::Base 
	belongs_to :user
end 

class Comment < ActiveRecord::Base 
	belongs_to :user
	belongs_to :post 
end 