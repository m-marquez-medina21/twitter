Rails.application.routes.draw do
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
