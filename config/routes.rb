Rails.application.routes.draw do

  devise_for :users

  resources :wikis
  resources :collaborators, only: [:create, :destroy]

  get 'users/upgrade'

  resources :users do
    collection do
      get "upgrade"
    end
    post "toggle_role"
    post "go_standard"
  end

  resources :charges, only: [:new, :create]

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
