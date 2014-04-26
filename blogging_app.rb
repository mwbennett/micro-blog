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
	@user = User.create(params[:user])
	flash[:notice] = "Welcome to MicroBlogger."
	erb :home
end
=begin
	if @user.valid?
		@user.save
		redirect '/home'
	else
		erb :signup
		flash[:alert] = "#{@errors.values}" 
	end
=end



post '/sign_in' do
	@user = User.where(username: params[:username]).first
	if  @user.password == params[:password]
		flash[:notice] = "Login successful."
		erb :home
	else 
		flash[:alert] = "Incorrect username or password."
		erb :log_in
	end
end

post '/create_post' do
	@post = Post.create(params[:post])
	flash[:notice] = "Posted successfully."
	erb :home
end
=begin	
	if @post.valid?
		@post.save
		redirect'/home'
	else
		erb :create
		flash[:alert] = "#{@errors.values}"
=end