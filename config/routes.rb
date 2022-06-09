Rails.application.routes.draw do

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
    end
    # get '/customers/:id' => 'public/customers#show', as: "customers"
    # get '/customers/:id/edit' => 'public/customers#edit', as:"edit_customers"
    # patch '/customers/:id' => 'public/customers#update'
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
