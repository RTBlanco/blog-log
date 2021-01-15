class UserController < ApplicationController 

  get '/users/:user' do 
    @user = User.find_by(username: params[:user])

    if !@user.nil?
      @posts = @user.posts
      erb :"user/show"
    elsif params[:username] == current_user.username
      redirect '/account'
    else
      redirect to '/posts'
    end
  end
 
  get '/account' do 
    if logged_in?
      @user = current_user
      @posts = @user.posts
      erb :'user/show'
    else
      redirect to '/posts'
    end
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
    if !params[:name].empty?
      current_user.name = params[:name]
    end

    if !params[:password].empty?
      current_user.password = params[:password]
    end
    current_user.save
    redirect to "/account"
  end

  delete '/account/edit' do 
    current_user.destroy
    redirect to '/logout'
  end

  get '/account/feed' do
    if logged_in?
      @posts = current_user.followees.map {|user| user.posts}.flatten.reverse()
      erb :"user/feed"
    else
      redirect to '/posts'
    end
  end
end
