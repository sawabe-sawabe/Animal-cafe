class GroupsController < ApplicationController
  before_action :authenticate_user!

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(post_group_params)
    @group.owner_id = current_user.id
    @group.users << current_user
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @users = User.where(id: @group.users.ids)
    @post_images = PostImage.where(user_id: @users.ids).order('created_at DESC') # 新規投稿順になるように並び替え
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(post_book_params)
      redirect_to request.referer
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_path
  end

  def board
    @group = Group.find(params[:group_id])
    @group_board = GroupBoard.new
  end

  private

  def post_group_params
    params.require(:group).permit(:name, :profile_image, :introduction, :word, :owner_id)
  end
end
