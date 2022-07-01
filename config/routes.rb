Rails.application.routes.draw do

#会員側
  devise_for :customers, skip:[:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :customer do
    root to: "public/home#top"
    get '/about' => 'public/home#about'
    post "customers/guest_sign_in", to: "public/sessions#guest_sign_in" #public/sessionsコントローラのguest_sign_inアクションを行う
    resources :customers, only:[:show, :edit, :update], controller: "public/customers" do
      resource :relationships, only:[:create, :destroy], controller: "public/relationships"#フォロー機能
      get '/followings' => 'public/relationships#followings'#フォロー一覧
      get '/followers' => 'public/relationships#followers'#フォロワー一覧
      get '/favorites' => 'public/customers#favorites'#いいね一覧
    end
    get 'customers/:id/unsubscribe' => 'public/customers#unsubscribe', as: "unsubscribe"
    patch '/customers/:id/withdrawal' => 'public/customers#withdrawal', as: "withdrawal"#退会
    resources :post_images, only:[:new, :create, :show, :index, :edit, :update, :destroy], controller: "public/post_images" do
       resource :favorites, only:[:create, :destroy], controller: "public/favorites"#いいね機能
       resources :post_comments, only:[:create, :destroy], controller: "public/post_comments"#コメント機能
    end
    resources :chats, only:[:show, :create, :destroy], controller: "public/chats"#DM機能
    resources :notifications, only:[:index], controller: "public/notifications" #通知一覧
    delete "/notifications/destroy_all" => "public/notifications#destroy_all", as: "destroy_all"
    get '/search' => 'public/searchs#search'#検索機能
  end

#管理者側
  devise_for :admin, skip:[:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get '/top' => 'home#top'
    resources :customers, only:[:show, :edit, :update]
    resources :post_images, only:[:show, :index, :destroy] do
      resources :post_comments, only:[:destroy]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
