Rails.application.routes.draw do
  
  devise_for :customers, skip:[:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  devise_scope :public do
    root to: "public/home#top"
    #public/sessionsコントローラのguest_sign_inアクションを行う
    post "customers/guest_sign_in", to: "public/sessions#guest_sign_in"
    get '/about' => 'public/home#about'
    get '/customers/:id' => 'public/customers#show', as: "customers"
    get '/customers/:id/edit' => 'public/customers#edit', as:"edit_customers"
    get 'customers/unsubscribe' => 'public/customers#unsubscribe'
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
