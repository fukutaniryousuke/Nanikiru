Rails.application.routes.draw do

  root to: "public/home#top"
  get '/about' => 'public/home#about'

  namespace :admin do
    get '/top' => 'home#top'
    resources :customers, only:[:show, :edit, :update]
  end


  devise_for :admin, skip:[:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers, skip:[:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
