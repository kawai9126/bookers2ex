Rails.application.routes.draw do
  resources :videos
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get "about" => "homes#about"
  
  get 'chat/:id' => 'chats#show', as: 'chat'
  
  get 'ranking' => 'books#rank'
  
  resources :maps
  
  resources :contact,only: [:new,:create]
  
  resources :searchs,only: [:index]
  
  resources :videos,only: [:new,:show]
  
  resources :users do
    get :search, on: :collection
  end
  
  resources :chats, only: [:create]
  
  resources :users do
    get :search, on: :collection
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  
end
