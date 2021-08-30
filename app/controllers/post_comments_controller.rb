class PostCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :baria_user, only: [:destroy]

  def create
    @post_image = PostImage.find(params[:post_image_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.post_image_id = @post_image.id
    @post_comment.user_id = current_user.id

    unless @post_comment.save # 空白では投稿できないようにする
      render :show
    end
  end

  def destroy
    @post_image = PostImage.find(params[:post_image_id])
    @post_comment = @post_image.post_comments.find(params[:id])
    @post_comment.destroy
  end

  def index
    @user = User.find(params[:user_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end

def baria_user
    @post_image = PostImage.find(params[:post_image_id])
    @post_comment = @post_image.post_comments.find(params[:id])
    unless @post_comment.user_id == current_user.id
         redirect_to post_image_path(@post_image.id)
    end
end
