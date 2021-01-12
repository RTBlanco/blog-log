class UserController < ApplicationController 

  get '/:user' do 
    if in_db?(params)
      @user = User.find_by(username: params[:username])
      @posts = @user.posts
      erb :"user/show"
    else
      redirect to '/posts'
    end
  end
end
