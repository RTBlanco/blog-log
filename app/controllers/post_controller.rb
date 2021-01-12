class PostController < ApplicationController
  get "/posts" do 
    @posts = Post.all
    erb :'posts/index'
  end

  get '/posts/new' do 
    erb :'posts/new'
  end
  
  post '/posts/new' do 
    # binding.pry
    post = Post.create(title: params[:title], content: params[:content])
    current_user.posts << post
    redirect to "/posts/#{post.id}"
  end

  get '/posts/:id' do 
    @post = Post.find(params[:id])
    erb :"posts/show"
  end

  get '/posts/:id/edit' do
  end

end
