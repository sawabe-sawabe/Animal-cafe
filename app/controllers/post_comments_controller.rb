class PostCommentsController < ApplicationController
 before_action :authenticate_user!
 def create
   @post_image = PostImage.find(params[:post_image_id])
   @comment = current_user.post_comments.new(post_comment_params)
   @comment.post_image_id = @post_image.id
   unless @comment.save
     render :show
   end
 end

 def destroy
   @post_image =PostComment.find_by(id:params[:id],post_image_id:params[:post_image_id]).destroy
   
 end

 def index
   @user = User.find(params[:user_id])
 end

private

def post_comment_params
   params.require(:post_comment).permit(:comment)
end
end
