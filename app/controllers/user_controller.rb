class UserController < ApplicationController 

  get '/users/:user' do 
    if in_db?(params[:user])
      @user = User.find_by(username: params[:user])
      @posts = @user.posts
      erb :"user/show"
    else
      redirect to '/posts'
    end
  end

  get '/account' do 
    @user = User.find(session[:user_id])
    erb :'user/edit'
  end

  patch '/account' do 
    @user = User.find(session[:user_id])
    @user.update(name: params[:name], password: params[:password])
    redirect to "/account"
  end

  delete '/account' do 
    @user = User.find(session[:user_id])
    @user.delete
    redirect to '/posts'
  end

end
