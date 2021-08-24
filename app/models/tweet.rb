class Tweet < ApplicationRecord
    validates :content, presence: true
    belongs_to :user
    has_many :retweets, class_name: 'Tweet', foreign_key: 'tweet_id', dependent: :destroy
    belongs_to :original_tweet, class_name: 'tweet', foreign_key: 'tweet_id', optional: true
    has_many :likes, dependent: :destroy
end
