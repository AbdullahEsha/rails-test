Rails.application.routes.draw do
  devise_for :users

  root 'home_page#index'

  resources :product_page do
    resources :reviews, only: %i[create destroy]
  end
end