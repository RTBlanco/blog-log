class PostController < ApplicationController
  get "/posts" do 
    @posts = Post.all
    erb :'posts/index'
  end

  get '/posts/new' do
    if logged_in? 
      erb :'posts/new'
    else 
      redirect to '/posts'
    end
  end
  
  post '/posts/new' do 
    # binding.pry
    post = Post.new(title: params[:title], content: params[:content])
    if post.save
      current_user.posts << post
      redirect to "/posts/#{post.id}"
    else
      redirect to '/posts/new'
    end
  end

  get '/posts/:id' do 
    if post_in_db?(params[:id])
      @post = Post.find(params[:id])
      erb :"posts/show"
    else
      redirect to '/posts'
    end
  end

  get '/posts/:id/edit' do
  end

end
