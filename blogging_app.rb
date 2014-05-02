# Requiring libraries
# 
require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'rack-flash'
enable :sessions
use Rack::Flash, :sweep => true

require './models.rb'

# Configuration 
# 
set :database, "sqlite3:///blog.sqlite3"
set :sessions, true 

# Routes 
# 
get '/about' do 
	erb :about
end 

get '/create' do 
	erb :create
end 

get '/' do 
	@posts = Post.order("created_at DESC")

	erb :home
end 

get '/login' do 
	erb :log_in
end 

get '/signup' do 
	erb :sign_up
end 

post '/sign_up' do
	@user = User.new(params[:user])
	if @user.valid?
		@user.save
		flash[:notice] = "Welcome to MicroBlogger."
		redirect '/'
	else
		flash[:notice] = @errors.values
		redirect '/signup'
	end
end

post '/sign_in' do
	@user = User.where(username: params[:username]).first
	if @user && ( @user.password == params[:password] )
		session[:user_id] = @user.id
		flash[:notice] = "Login successful."
		redirect '/'
	else 
		flash[:notice] = @errors.values
		redirect '/login'
	end
end

post '/create_post' do
	@post = Post.new(params[:post])
	if @post.valid?
		@post.save
		flash[:notice] = "Posted successfully."
		redirect'/'
	else
		redirect '/create'
		flash[:notice] = @errors.values
	end
end

get '/logout' do
	session[:user_id] = nil
	redirect '/'
end


# Helpers 
# 
def current_user 
	if session[:user_id]
		@current_user = User.find(session[:user_id])
	end	
end