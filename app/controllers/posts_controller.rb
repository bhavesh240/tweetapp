class PostsController < ApplicationController
  
  def new
    @post = Post.new
    @post.images.build
  end

  def create
    @post = current_user.posts.new(post_params)
    
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def show
    find_post_by_id
  end

  def index
    @posts = Post.all
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    find_post_by_id

    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    find_post_by_id
    @posts = Post.all

    if ((@post[:user_id] == current_user.id) || current_user.has_role?("admin"))
      @post.destroy
      respond_to do |format|
        format.html
        format.js
      end 
    end
  end

  def verify_post
    find_post_by_id
    @posts = Post.all

    @post.update_columns(verify: true) if !@post.verify
    respond_to do |format|
      format.html do 
        redirect_to posts_path
      end
      format.js
    end
  end

  private
  def post_params
    params.require(:post).permit(:title,:body,images_attributes: [:image,:id,:_destroy]).merge({user_id: current_user.id})
  end
 
  def find_post_by_id
    @post = Post.find(params[:id])
  end
end
