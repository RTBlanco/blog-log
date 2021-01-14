# require 'rack-flash'
class PostController < ApplicationController
  # use Rack::Flash

  get "/posts" do 
    @posts = Post.all.reverse()
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
    post = Post.new(title: params[:title], content: params[:content])
    if post.save
      current_user.posts << post
      flash[:message] = "uploaded!"
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
    if post_in_db?(params[:id])
      @post = Post.find(params[:id])
      if @post.user == current_user
        erb :'posts/edit'
      else
        redirect to "/post/#{@post.id}"
      end
    else
      redirect to "/posts"
    end
  end

  patch '/posts/:id' do
    post = Post.find(params[:id])
    if !params[:title].empty?
      post.title = params[:title]
    end

    if !params[:content].empty?
      post.content = params[:content]
    end
    post.save
    flash[:message] = "Blog Updated!"
    redirect to "/posts/#{post.id}"
  end

  delete '/posts/:id' do
    post = Post.find(params[:id])
    post.delete
    flash[:message] = "Blog Deleted!"
    redirect to "/account"
  end

end
