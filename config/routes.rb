Rails.application.routes.draw do
  devise_for :users

  resources :users, only:[:show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get "delete"
    get "favorites"
    get "comments"
    get :follows, on: :member
    get :followers, on: :member
    resources :diaries, only:[:new, :create, :destroy, :edit, :update] do
      resource :favorites, only: [:create, :destroy]
      resource :comments, only: [:create, :destroy, :edit, :update]
    end
  end

  resources :diaries, only:[:index, :show]

  resources :tags, only:[:index, :edit, :update, :create, :destroy]

  root 'home#top'
  get 'home/about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
