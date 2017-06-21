Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :games
  resources :purchases
  root to: 'games#index'
  post "users/toggle_staff" => "users#toggle_staff"
  post 'games/ajaxFunction'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
