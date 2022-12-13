Rails.application.routes.draw do
  resources :books, only: %i[index update create]
  root to: 'main#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
