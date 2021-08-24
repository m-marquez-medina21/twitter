Rails.application.routes.draw do
  resources :tweets
  # resources :likes
  devise_for :users
  root to: "tweets#index"
  post 'tweets/retweet/:id', to: 'tweets#retweet', as: 'retweet'
  post 'tweets/:tweet_id/likes', to: 'likes#like', as: 'like'
  delete 'likes/:id', to: 'likes#dislike', as: 'dislike'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
