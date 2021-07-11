class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @images =PostImage.where(user_id: current_user.id)
    @post_images = @user.post_images
    @post_comments = PostComment.where(user_id: current_user.id)
  end

  def index
    @users = User.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = user.find(params[:id])
    @users.update(user_params)
  end

  def followings
     @followings = @user.following_users
  end

  def followers
     @followers = @user.follower_users
  end

private

def user_params
  params.require(:user).permit(:name, :profile_image, :introduction,:having_pets,:favorite_animal)
end

end
