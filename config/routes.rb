Rails.application.routes.draw do
  devise_for :users, controllers:{
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  resources :users, only:[:show, :edit, :update] do
    post 'follow/:id' => 'relationships#follow', as: 'follow'
    post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
    get 'delete'
    get 'favorites'
    get 'comments'
    get 'follows'
    get 'followers'
    resources :diaries, only:[:new, :create, :destroy, :edit, :update] do
      collection do
        post 'new' => 'diaries#new',as: 'diaries_new'
      end
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
