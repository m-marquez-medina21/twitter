json.extract! tweet, :id, :content, :retweet, :rt_ref, :created_at, :updated_at
json.url tweet_url(tweet, format: :json)
