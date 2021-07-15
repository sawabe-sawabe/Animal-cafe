class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images
    @post_comments = PostComment.where(user_id: @user.id)
  end

  def index
    @users = User.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = user.find(params[:id])
    if @users.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end


private

def user_params
  params.require(:user).permit(:name, :profile_image, :introduction,:having_pets,:favorite_animal)
end

end
