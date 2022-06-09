Rails.application.routes.draw do

  namespace :public do
    get 'relationships/followings'
    get 'relationships/followers'
  end
  devise_for :customers, skip:[:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :customer do
    root to: "public/home#top"
    get '/about' => 'public/home#about'
    #public/sessionsコントローラのguest_sign_inアクションを行う
    post "customers/guest_sign_in", to: "public/sessions#guest_sign_in"

    resources :customers, only:[:show, :edit, :update], controller: "public/customers" do
      resource :relationships, only:[:create, :destroy], controller: "public/relationships"
      get '/followings' => 'public/relationships#followings'
      get '/followers' => 'public/relationships#followers'
    end
    
    get 'customers/:id/unsubscribe' => 'public/customers#unsubscribe', as: "unsubscribe"
    patch '/customers/:id/withdrawal' => 'public/customers#withdrawal', as: "withdrawal"

    resources :post_images, only:[:new, :create, :show, :index, :edit, :update, :destroy], controller: "public/post_images" do
       resource :favorites, only:[:create, :destroy], controller: "public/favorites"
       resources :post_comments, only:[:create, :destroy], controller: "public/post_comments"
    end

  end

  devise_for :admin, skip:[:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get '/top' => 'home#top'
    resources :customers, only:[:show, :edit, :update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
