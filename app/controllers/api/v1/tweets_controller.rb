class Api::V1::TweetsController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  #autenticacion para poder accceder a api
    http_basic_authenticate_with name: "hello", password: "123123"

    #visualizacion api
    def news 
        tweets = Tweet.all.order(created_at: :desc).limit(50)
        @tweets = tweets.map {|tweet| { 
            id: tweet.id, 
            content: tweet.content, 
            user: tweet.user_id,
            like_count: tweet.likes.count,
            retweets: tweet.tweet_id, 
            retwitter_from: tweet.user_id
            }}
        render json: @tweets
    end

#busqueda segun fechas date_init y date_end
    def date
        @tweets = Tweet.where('created_at BETWEEN ? AND ?', params[:date_init], params[:date_end])
        @api_date = []
        @tweets.each do |tweet|
        @api_date << { 
            id: tweet.id, 
            content: tweet.content, 
            user: tweet.user_id,
            like_count: tweet.likes.count,
            retweets: tweet.tweet_id, 
            retwitter_from: tweet.user_id
            }
        end
        render json: @tweets
    end
    #creacion de tweet usuario
    def create
        @tweet =  User.first.tweets.create(content: params[:content])
    
        if @tweet.save
            render json: @tweet, status: :created
        else
            render json: @tweet.errors, status: :unprocessable_entity
        end
    end

    def update
        if @tweet.update(tweet_params)
            render json: @tweet, status: :ok
        else
            render json: @tweet.errors, status: :unprocessable_entity
        end
    end
    def destroy
        @tweet.destroy
        head :no_content
    end
    private

    def set_new
        @tweet = Tweet.find(params[:id])
    end
    
end
