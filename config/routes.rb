Rails.application.routes.draw do
  resources :reports
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :books
  resources :users, only: %i(index show)
  get 'users/:user_id/reports', to: 'reports#index', as: 'user_reports'
  get 'users/:user_id/reports/:id', to: 'reports#show', as: 'user_report'
end
