class ImagesController < ApplicationController

 def create
  #@post = Post.find(params[:post_id])
   #@image = @post.images.create(image_params)
   #@image.save
   #@imageable = imageable
   #@image = @imageable.images.create(image_params)
 end

   private
   
   def imageable
     if params[:user_id]
       User.find(params[:user_id])

     elsif params[:post_id]
       Post.find(params[:post_id])
     end
   end

   def image_params
     params.require(:image).permit!
   end
end
