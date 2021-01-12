require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/login' do 
    erb :'sessions/login'
  end

  get "/" do
    redirect to '/login'
  end

  post '/sessions' do 
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/posts'
    else 
      redirect to '/login'
    end
  end

  get '/signup' do 
    erb :'registrations/signup'
  end

  post '/registration' do
    user = User.new(username: params[:username], password: params[:password])

    if in_db?(user) && user.save
      session[:user_id] = user.id
      redirect to '/posts'
    else
      redirect to '/signup'
    end   
  end

  helpers do 
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
     
    def in_db?(username) # this one could be a User class method 
      User.find_by(username: username) == nil ? false : true 
    end
  end

  
end
