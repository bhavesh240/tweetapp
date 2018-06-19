class CommentsController < ApplicationController
  
  def create
    find_post_by_id
    @comment = @post.comments.create(comment_params)

    @count_comment = @post.comments.count
    

    if @comment.save 
      respond_to do |format|
        format.html do
          redirect_to post_path(@post)
        end
        format.json { head :no_content }
        format.js 
    end
  end
  end
  
  def destroy
    find_post_by_id
    @comment = @post.comments.find(params[:id])

    @comment.destroy if current_user.id == @comment[:user_id]
  
    respond_to do |format|
      format.html
      format.js 
    end
    #redirect_to post_path(@post)
  end

  def show
    @comments = Comment.all
  end

  private
  def comment_params
    params.require(:comment).permit(:comment).merge({user_id: current_user.id})
  end
 
  def find_post_by_id
    @post = Post.find(params[:post_id])
  end

end
