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
get '/' do 
	erb :home
end 
