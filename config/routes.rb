Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # ルートページ
  # root to: "variouses#top"

  # ユーザーアクション

  #検索機能

  #新規会員登録の時のルーティングエラーを修正
  get '/users', to: redirect("/user/sign_up")

  # ユーザー機能
  resources :users,             only: [:show, :edit, :upate, :destroy] do
    resources :relationships,   only: [:create, :destroy]
    get :follows,   on: :member
    get :followers, on: :member
  end

  # 投稿機能
  resources :user_posts, only: [:new, :create, :index, :edit, :update, :destroy] do
    resources :post_comments, only: [:create, :update, :destroy]
  end

  # ルーム機能
  resources :talk_rooms do
    resources :talks,  only: [:create, :update]
    resources :room_media, only:  [:create, :update]
    resources :room_notes, only: [:create, :update, :destroy] do
      resources :room_note_media, only: [:create, :update]
    end
    resources :room_albums,     only: [:create, :update, :destroy]
    resources :room_events,     only: [:create, :update, :destroy]
    resource  :room_user,       only: [:create, :destroy]
    resource  :room_favorites,  only: [:create, :destroy]
  end

  # 通知機能
  resources :notification, only: [:index]
end
