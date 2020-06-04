Rails.application.routes.draw do
  devise_for :users, controllers:{
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  resources :users, only:[:show] do
    post 'follow/:id' => 'relationships#follow', as: 'follow'
    post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
    get 'delete'
    get 'favorites'
    get 'comments'
    get 'follows'
    get 'followers'
    resources :diaries, only:[:new, :create, :destroy, :edit, :update]
  end

  resources :diaries, only:[:index, :show] do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :tags, only: [:create, :index, :destroy, :update]

  root 'home#top'
  get 'home/about'
  get 'home/info'
  post 'home/info' => 'home#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
