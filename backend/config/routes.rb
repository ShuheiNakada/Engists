Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'auth/registrations'
  }

  namespace :api do
    resources :articles, only: [:index, :show, :create, :update] do
      resources :comments, only: [:index, :create, :destroy]
    end

    resources :healthcheck, only: [:index]

    resources :users, only: [:show, :index] do
      member do
        get :following, :followers
      end
    end

    resources :relationships, only: [:create, :destroy]

    resources :profiles, only: [:create, :update]

    resources :likes, only: [:create, :destroy]

    resources :rooms, only: [:show, :create]

    resources :messages, only: [:create, :destroy]

    resources :entries, only: [:index]

    resources :notifications, only: [:index, :update]

    resources :searches, only: [:index]

    get '/search', to: 'searches#search'
    get '/my_profile', to: 'users#profile'
    get '/my_articles', to: 'articles#my_articles'
    get '/likes', to: 'likes#likes'
    get '/like_articles', to: 'articles#like_articles'
    get '/like_article_rank', to: 'ranks#like_article_rank'
    get '/follow_user_rank', to: 'ranks#follow_user_rank'
    put '/dm_notifications/all_read', to: 'notifications#all_read'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
