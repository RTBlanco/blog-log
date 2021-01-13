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
    @user = current_user
    erb :'user/edit'
  end

  patch '/account' do 
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

  delete '/account' do 
    @user = User.find(session[:user_id])
    @user.delete
    redirect to '/logout'
  end

end
