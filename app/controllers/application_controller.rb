require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

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

    if !user_in_db?(user.username) && user.save
      session[:user_id] = user.id
      redirect to '/posts'
    else
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
      like(post)
      redirect to '/posts'
    when "posts/id"
      post = Post.find(params[:"posts/id"])
      like(post)
      redirect to "/posts/#{post.id}"
    when 'account'
      post = Post.find(params[:account])
      like(post)
      redirect to "/users/#{post.user.username}"
    end
  end

  helpers do
    
    def like(post)
      post.likes += 1
      post.save
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
     
    def user_in_db?(username) # this one could be a User class method 
      User.find_by(username: username) == nil ? false : true 
    end

    def post_in_db?(post_id)
      Post.find_by(id: post_id) == nil ? false :true
    end
  end  
end
