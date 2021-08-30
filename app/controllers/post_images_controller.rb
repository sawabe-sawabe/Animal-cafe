class PostImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :baria_user, only: [:destroy]
  def index
    @post_images = PostImage.all.order('created_at DESC') # 新規投稿順になるように並び替え
    @genres = Genre.all
  end

  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    if @post_image.save
      redirect_to post_image_path(@post_image.id)
    else
      render :new
    end
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
    @image_url = "https://animal-cafe-resize.s3-ap-northeast-1.amazonaws.com/store/" + @post_image.image_id + "-thumbnail."
  end

  def edit
    @post_image = PostImage.find(params[:id])

    unless @post_image.user == current_user
      redirect_to post_image_path(@post_image.id)
    end
  end

  def update
    @post_image = PostImage.find(params[:id])

    if @post_image.update(post_image_params)
      redirect_to post_image_path(@post_image.id)
    else
      render :edit
    end
  end

  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_to post_images_path
  end

  private

  def post_image_params
    params.require(:post_image).permit(:title, :genre_id, :image, :caption)
  end
end

def baria_user
    unless @group.group_boards.find(params[:id]) == current_user.id
        redirect_to tasks_path(current_user)
    end
end
