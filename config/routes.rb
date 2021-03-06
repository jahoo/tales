Tales::Application.routes.draw do
  localized do
    devise_for :users, controllers: {
      confirmations: "users/confirmations",
      omniauth_callbacks: "users/omniauth_callbacks", 
      passwords: "users/passwords",
      registrations: "users/registrations", 
      sessions: "users/sessions"
    }
    devise_scope :user do    
      get "users/thank_you", to: "users/registrations#thank_you"
    end
    
    resources :users, only: [:show, :index] do
      resource :admin, only: [:create, :destroy], on: :member, controller: "users/admins"
      resources :games, only: :index, controller: "users/games"
    end
    resources :saves, only: [:index, :destroy]
    
    resources :games do
      resource :mark, only: [:create, :update]
      get "mark", to: "marks#create"
      get "publish", to: "games#publish", on: :member
      get "unpublish", to: "games#unpublish", on: :member
      resources :paragraphs do
        get "save", to: "saves#create", on: :member
        get "set_as_first", to: "paragraphs#set_as_first", on: :member
        resources :choices, except: [:index, :show]
      end
    end
    
    get "faq", to: "home#faq"
    
    root to: "home#index"
  end
end
