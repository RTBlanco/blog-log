require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :"welcome"
  end

  get "/posts" do 
    @posts = Post.all
    erb :"post/index"
  end
end
