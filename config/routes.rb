Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'}do
    namespace :v1 do
      get 'news', to: 'tweets#news'
      get 'date/:date_init/:date_end', to: 'tweets#date', as: 'date'
      get 'create', to: 'tweets#create'
    end
  end
 
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :tweets
  # resources :likes
  devise_for :users
  root to: "tweets#index"
  post 'tweets/retweet/:id', to: 'tweets#retweet', as: 'retweet'
  post 'tweets/:tweet_id/likes', to: 'likes#like', as: 'like'
  delete 'likes/:id', to: 'likes#dislike', as: 'dislike'
  post 'follows/:id', to: 'follows#follow', as: 'follow'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
