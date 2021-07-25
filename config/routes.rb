Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'about' => 'homes#about'

  resources :users, only: [:show, :edit, :index, :update] do
    resource :relationships, only: [:create, :destroy] # フォロー・フォロー解除
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers' # フォローフォロワー一覧取得
    resources:favorites, only: [:index]
    resources:post_comments, only: [:index]
    resources:group_users, only: [:index]
  end

  resources :post_images do
    resources:post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :genres, only: [:new, :create, :edit, :update]

  resources :chats, only: [:show, :create] # DM機能

  get 'search' => 'searches#search' # ユーザー・投稿検索機能
  get 'match' => 'searches#match' # ジャンル検索機能

  resources :groups do
    resources:group_users, only: [:index]
    resources:group_boards, only: [:create, :destroy]
    resource :group_users, only: [:create, :destroy]
    get 'board' => 'groups#board'
    get 'member' => 'group_users#member' # グループメンバー一覧を取得
  end
end
