class PostsController < ApplicationController
  def index
    #@post = Posts.all
  end

  def new
    @post = Post.new
  end
end
