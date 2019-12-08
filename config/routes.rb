Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_scope :user do
    get 'auth/sign_out' => 'auth/sessions#destroy'
  end

  devise_for :users, path: 'auth', controllers: {
      # omniauth_callbacks: 'auth/omniauth_callbacks',
      sessions:           'auth/sessions',
      registrations:      'auth/registrations',
      passwords:          'auth/passwords',
      confirmations:      'auth/confirmations',
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # resources :posts

  resources :posts do
    resources :comments
  end

  resources :category do
    resources :posts, only: [:index]
  end


  resources :comments do
    resources :comments
  end

  resources :tags
  resources :categories


  root to: 'posts#index'
end
