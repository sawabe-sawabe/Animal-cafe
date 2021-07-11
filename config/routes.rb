Rails.application.routes.draw do



  get 'users/show'
  get 'users/index'
  get 'users/followings'
  get 'users/followers'
  devise_for :users
  root'homes#top'
  get'about' =>'homes#show'

  resources :users, only:[:show,:edit,:index,:update] do
   member do
      get :followings, :followers #フォローフォロワー一覧取得
    end
     resources :relationships, only:[:create,:destroy] #フォロー・フォロー解除
   resources:favorites, only:[:index]
   resources:post_comments, only:[:index]
  end

  resources :post_images do
   resources:post_comments, only:[:create,:destroy]
   resources:favorites, only:[:create,:destroy]
  end


  resources :genres, only:[:new,:create,:edit,:update]

  post'rooms' =>'rooms#create' #DM機能
  get'rooms/:id' =>'rooms#show' #DM機能

  post'messages' =>'messages#create'  #DM機能




end
