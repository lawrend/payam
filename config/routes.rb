Rails.application.routes.draw do
  resources :styles do
    resources :corpses, :path => "payams"
  end
  resources :lines, :except => [:update, :edit] 
  resources :corpses, :path => "payams" do
    member do
      post 'decompose'
    end
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :players do
    resources :corpses, :path => "payams"
    resources :lines
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get 'welcome/about'


  # keep user id out of the visible url
  get 'player' => 'players#show'
end
