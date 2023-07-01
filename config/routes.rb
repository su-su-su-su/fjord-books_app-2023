Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'

  resources :books do
    resources :comments, module: :books, only: [:create, :update, :edit, :destroy]
  end

  resources :reports do
    resources :comments, module: :reports, only: [:create, :update, :edit, :destroy]
  end

  resources :users, only: %i(index show)

end
