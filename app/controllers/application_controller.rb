require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end
  use Rack::Flash
  
  get '/login' do 
    if logged_in?
      redirect to '/posts'
    else
      erb :'sessions/login'
    end
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
      flash[:message] = "Username and/or password is incorrect"
      redirect to '/login'
    end
  end

  get '/signup' do 
    if logged_in?
      redirect to '/posts'
    else  
      erb :'registrations/signup'
    end
  end

  post '/registration' do
    user = User.new(username: params[:username], password: params[:password], name: params[:name])

    if User.find_by(username: user.username).nil? && user.save
      session[:user_id] = user.id
      redirect to '/posts'
    else
      flash[:message] = "Username is already in use."
      redirect to '/signup'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login' 
  end


  post '/like' do 
 
    case params.keys.first
    when "posts"
      post = Post.find(params[:posts])
      post.like
      redirect to '/posts'
    when "posts/id"
      post = Post.find(params[:"posts/id"])
      post.like
      redirect to "/posts/#{post.id}"
    when 'account'
      post = Post.find(params[:account])
      post.like
      redirect to "/users/#{post.user.username}"
    end
  end

  post '/follow' do 
    if params.keys.first == "follow"
      user = User.find(params[:follow])
      current_user.follow(user)
      redirect to "users/#{user.username}"
    else
      user = User.find(params[:unfollow])
      current_user.unfollow(user)
      redirect to "users/#{user.username}"
    end
  end

  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
    
  end  
end
