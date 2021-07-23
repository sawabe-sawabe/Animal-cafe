class GroupBoardsController < ApplicationController
  before_action :authenticate_user!
 def create
   group = Group.find(params[:group_id])
   message = current_user.message.new(message_params)
   message.group_id = group.id
   if group.save
     redirect_to request.referer
   else
     render :show
   end
 end

 def destroy
   PostComment.find_by(id:params[:id],post_image_id:params[:post_image_id]).destroy
   redirect_to request.referer
 end

 def index
   @user = User.find(params[:user_id])
 end

private

def post_comment_params
   params.require(:post_comment).permit(:comment)
end
end

end
