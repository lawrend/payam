Rails.application.routes.draw do
  resources :styles
  resources :lines
  resources :corpses, :path => "payams"
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :players do
    resources :corpses
    resources :lines
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get 'welcome/about'
  get 'player' => 'players#show'
end
