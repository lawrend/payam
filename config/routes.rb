Rails.application.routes.draw do
  resources :styles
  resources :lines
  resources :corpses
  devise_for :users
  resources :players
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get 'welcome/about'
  get 'player' => 'players#show'
end
