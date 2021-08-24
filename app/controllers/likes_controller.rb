class LikesController < ApplicationController
before_action :authenticate_user! #solo usuario regustrado puede dar like
    def like
        tweet = Tweet.find(params[:tweet_id]) #id del tweet
        new_like = Like.create(tweet: tweet, user: current_user)#nos permite crear el like
        redirect_to root_path #redirecciona al index
    end

    def dislike
        tweet = Tweet.find(params[:id])#id del tweet
        like = tweet.likes.find_by(user: current_user)
        like.destroy #destruye el like
        redirect_to root_path
    end
end
