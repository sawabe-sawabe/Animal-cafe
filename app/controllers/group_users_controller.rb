class GroupUsersController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  end

  def member
    @users = User.where(params[:group_id])
    @group = Group.find(params[:group_id])
  end

  def create
    @group = Group.find(params[:group_id])
    group_user_join = current_user.group_users.new(group_id: @group.id)
    group_user_join.save
    redirect_to request.referer
  end

  def destroy
     @group = Group.find(params[:group_id])
     group_user_join = current_user.group_users.find_by(group_id: @group.id)
     group_user_join.destroy
     redirect_to request.referer
  end



end
