class SearchesController < ApplicationController
 
 def search
   @range = params[:range]
   search = params[:search]
   word = params[:word]
   if  @range == '1'
     @user = User.search(search,word)
   else  @post_image = "2"
     @post_image = PostImage.search(search,word)
   end
  end
 
 def match
   value = params[:value]
   @genre =Genre.find(params[:value].to_i)
   @post_image = PostImage.match(value)
 end


 end



