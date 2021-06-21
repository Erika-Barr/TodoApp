require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'todo_lists#index'
  resources :todo_lists do
    resources :todo_items # TODO - remove if possible
  end
end
