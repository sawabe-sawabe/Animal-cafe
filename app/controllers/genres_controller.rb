class GenresController < ApplicationController
  before_action :authenticate_user!
  def new
   @genre = Genre.new
   @genres = Genre.all
  end

  def create
   @genre = Genre.new(genre_params)
   if @genre.save
     redirect_to new_genre_path
   else
     redirect_to request.referer #一覧表示と新規登録画面が同じためrender不使用
   end
  end

  def edit
   @genre = Genre.find(params[:id])
  end

  def update
   @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
     redirect_to new_genre_path
    else
     render :edit
    end
  end

private
 def genre_params
   params.require(:genre).permit(:name)
 end
end