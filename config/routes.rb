Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "rotate", to: "pages#rotate"
  get "pioche", to: "pages#pioche"
  get "piocheup", to: "pages#piocheup"
  resources :players, only: [:create] do
    member do
      post :play
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
