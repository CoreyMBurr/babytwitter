require 'sinatra'
require 'sinatra/activerecord'
require './models'
require 'bundler/setup' 
require 'rack-flash'
enable :sessions
use Rack::Flash, :sweep => true

# set :database, "sqlite3:///satSinatra.sqlite3"
configure(:development){set :
database, "sqlite:///blog.sqlite3"}
set :sessions, true

# get '/' do
# 	# paste this into irb to create users and avoid dupes... (don't have to run this inside of a route.)
# 	# User.create(fname: 'Corey', lname: 'Burr', email: 'coreymburr@gmail.com', phone: 9732712306, username: 'CoreyMilesBurr86', password: 'thisIsMyPassword')

# 	erb :home
# end

def current_user
	# if someone is signed in
	if session[:user_id]
		User.find(session[:user_id])
	else
		nil
	end
	# return their user object
	# otherwise, return nill
end

get '/' do
	@user = current_user
	erb :home
end

get '/sign_in' do
	@user = current_user
	erb :sign_in
end

get '/signup' do
	flash[:notice] = "Please fill out the form below to sign up."
	erb :signup
end

post '/sessions/new' do 
	#look up the user in the database
	@user = User.where(username: params[:username]).first 
	if @user && @user.password == params[:password]
		flash[:notice] = "You have been successfully logged in."
		session[:user_id] = @user.id
		# then have the app remember the user is logged in 
	else
		redirect '/oops'
		flash[:alert] = "There was a problem signing you in."
	end
	# if they exist, check thier password
	redirect '/'
end

#display all posts from the logged in user session 

#########

get '/logout' do
	session[:user_id] = nil
	redirect '/sign_in'
end

get '/users/:id/addresses' do
	@user = User.find(params[:id])
	erb :addresses
end

post '/signup' do 
	puts "my params are" + params.inspect
	@user = User.create(params[:user])
	flash[:notice] = "You have been successfully logged in."
	session[:user_id] = @user.id
	redirect '/'
end

post '/home' do 
	paramsHash = params[:post]
	paramsHash[:user_id] = current_user.id
	@post = Post.create(paramsHash)
	redirect '/'
end

get '/news' do
	erb :news
end

get '/oops' do
	erb :oops
end

