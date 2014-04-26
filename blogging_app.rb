# Requiring libraries
# 
require 'sinatra'
require 'sinatra/activerecord'

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
	erb :home
end 

get '/login' do 
	erb :log_in
end 

get '/signup' do 
	erb :sign_up
end 


