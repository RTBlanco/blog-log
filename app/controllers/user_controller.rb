class UserController < ApplicationController 

  get '/users/:user' do 
    if user_in_db?(params[:user])
      @user = User.find_by(username: params[:user])
      @posts = @user.posts
      erb :"user/show"
    elsif params[:username] == current_user.username
      redirect '/account'
    else
      redirect to '/posts'
    end
  end
 
  get '/account' do 
    @user = current_user
    @posts = @user.posts
    erb :'user/show'
  end

  get '/account/edit' do
    if logged_in? 
      @user = current_user
      erb :'user/edit'
    else
      redirect to '/posts'
    end
  end

  patch '/account/edit' do 
    @user = current_user
    if !params[:name].empty?
      @user.name = params[:name]
    end

    if !params[:password].empty?
      @user.password = params[:password]
    end
    @user.save
    redirect to "/account"
  end

  delete '/account/edit' do 
    @user = current_user
    @user.posts.each {|post| post.delete}
    @user.delete
    redirect to '/logout'
  end

  get '/account/feed' do
    # binding.pry
    @posts = current_user.followees.map {|user| user.posts}.flatten.reverse()
    erb :"user/feed"
  end
end
