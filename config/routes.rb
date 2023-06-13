Rails.application.routes.draw do
  resources :reports
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'

  resources :books do
    resources :comments, only: [:create, :update]
  end

  resources :reports do
    resources :comments, only: [:create, :update]
  end

  resources :comments, only: [:edit, :destroy]

  resources :users, only: %i(index show)

end
