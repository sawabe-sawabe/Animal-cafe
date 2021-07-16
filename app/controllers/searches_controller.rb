class SearchesController < ApplicationController

  def search
    @range = params[:range] #rangeパラメーターを使用して、ユーザー検索と投稿検索を振り分けるため
    search = params[:search] #searchパラメーターを使用して、検索方法を分岐するため
    word = params[:word]

   #検索種類の振り分け
    if  @range == '1'
      @user = User.search(search,word)
    elsif  @post_image == "2"
      @post_image = PostImage.search(search,word)
    else
     flash[:alert] = "選択欄の項目は必須です。選択してください"
     redirect_to request.referer
    end

  end

  def match #ジャンル検索用
    value = params[:value] #ジャンルid代入にvalueパラメーターを使用
    if value == ""
      flash[:alert] = "ジャンルを選択してください"
      redirect_to request.referer
    else
      @post_image = PostImage.match(value)
      @genre =Genre.find(params[:value].to_i) #ジャンル名を検索結果に表示するため
    end
  end

end



