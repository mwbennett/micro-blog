# LIBRARIES
# 
require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'rack-flash'

require './models.rb'

# CONFIGURATION 
# 
set :database, "sqlite3:///blog.sqlite3"
set :sessions, true 
enable :sessions
use Rack::Flash, :sweep => true
# ROUTES 
# 

# get the about page 
get '/about' do 
	@title = "About"
	erb :about
end 

# get the new post form 
get '/create' do 
	@title = "New Post"
	erb :create
end 

# get the homepage, showing the most recent blog posts 
get '/' do 
	@posts = Post.order("created_at DESC")
	@title = "Home"
	erb :home
end 

# get the login page 
get '/login' do 
	@title = "Login"
	erb :log_in
end 

# get the signup page 
get '/signup' do 
	@title = "Sign Up"
	erb :sign_up
end 

# get the profile page of the user with the given id 
get '/users/:id' do
	@user = User.find(params[:id])
	@title = @user.username
	erb :"users/show"
end

# get the  page for the post with the given id
get '/posts/:id' do 
	@post = Post.find(params[:id])
	@title = @post.title
	erb :"posts/show"
end

# get the edit user form for the user with the given id 
get '/users/:id/edit' do
	@user = User.find(params[:id])
	@title = "Edit Profile"
	erb :"users/edit"
end


# get the edit post form for the post with the given id
get '/posts/:id/edit' do
	puts "flfjbeowbe"
	@post = Post.find(params[:id])
	@title = "Edit Post" 
	erb :"posts/edit"
end

# get request to logout a user and then redirect to homepage 
get '/logout' do
	session[:user_id] = nil
	redirect '/'	
end

# put request to edit the content of the user's profile. If successful, 
# redirect to the user's profile. If not, reload the edit form with 
# the user content still in memory 
put '/users/:id' do
	@user = User.find(params[:id])
	if @user.update_attributes(params[:user])
		redirect "/users/#{@user.id}"
	else
		erb :"users/edit"
	end
end

# put request to edit the content of the post. If successful, 
# redirect to the post's page. If not, reload the edit form with 
# the post content still in memory 
put '/posts/:id' do 
	@post = Post.find(params[:id])
	if @post.update_attributes(params[:post])
		redirect "/posts/#{@post.id}"
	else
		erb :"posts/edit"
	end
end

# sends a post request to create a new user. If the user is created 
# successfully, the user begins their session, and is redirected 
# to the homepage. Otherwise, they are redirected to the signup
# page.  
post '/sign_up' do
	@user = User.create(params[:user])
	if @user
		session[:user_id] = @user_id
		flash[:notice] = "Welcome to MicroBlogger."
		redirect '/'
	else
		flash[:notice] = "Please complete all fields."
		redirect '/signup'
	end
end

# sends a post request to log in an existing user. if successful, 
# begin the user's session, and redirect to the homepage; 
# if not successful, redirect to the login page
post '/sign_in' do
	@user = User.where(username: params[:username]).first
	if @user.password == params[:password] 
		session[:user_id] = @user.id
		flash[:notice] = "Login successful."
		redirect '/'
	else 
		flash[:notice] = "Login failed."
		redirect '/login'
	end
end

# sends a post request to create a new bog post. if successful,
# redirect to the homepage; if not, redirect to the create page
post '/create_post' do
	@post = current_user.posts.create(params[:post])
	if @post
		flash[:notice] = "Posted successfully."
		redirect'/posts/#{@post.id}'
	else
		flash[:notice] = "Something went wrong."
		redirect '/create'
	end
end

# deletes post with a given id and redirects to homepage 
delete '/posts/:id' do
	@post = Post.find(params[:id]).destroy
	redirect '/'
end

# HELPERS 
# 
def current_user 
	if session[:user_id]
		@current_user ||= User.find(session[:user_id])
	end	
end

def title 
	if @title
		"#{@title} -- MicroBlogger"
	else 
		"MicroBlogger"
	end
end

def delete_post_button(post_id)
	erb :_delete_post_button, locals: { post_id: post_id}
end
