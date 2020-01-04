require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base

	configure do
		set :views, "app/views"
		enable :sessions
		set :session_secret, "password_security"
	end

	get "/" do
	 # renders an index.erb file with links to signup or login
		erb :index
	end

	get "/signup" do
	  # renders a form to create a new user
		erb :signup
	end

	post "/signup" do
		#your code here!
    user = User.new(:username => params[:username], :password => params[:password])
   
   # won't be saved to the db unless our user filled out the password field
    if user.save
      redirect "/login"
    else
      redirect "/failure"
    end
	end

	get "/login" do
	 # renders a form for logging in
		erb :login
	end

  post "/login" do
    user = User.find_by(:username => params[:username])
   
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/success"
    else
      redirect "/failure"
    end
  end

	get "/success" do
	  # renders a success.erb page
	  # displayed once user successfully logs in
		if logged_in?
		  # @username = current_user.username
		  erb :success
		end
	end

	get "/failure" do
	  # accessed if there is an error logging in or signing up
		erb :failure
	end

	get "/logout" do
	 # clears the session data and redirects to the homepage
		session.clear
		redirect "/"
	end

	helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			@user = User.find(session[:user_id])
		end
	end

end
