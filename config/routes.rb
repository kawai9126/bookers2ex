Rails.application.routes.draw do
  resources :videos
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get "about" => "homes#about"
  
  get 'search' => 'search#search'
  
  get 'chat/:id' => 'chats#show', as: 'chat'
  
  resources :maps
  
  resources :videos
  
  resources :chats, only: [:create]
  
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  
end
