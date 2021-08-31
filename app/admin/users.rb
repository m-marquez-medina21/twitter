ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :user_name, :user_photo
  #
  # or
  #
  permit_params do
    permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :user_name, :user_photo, :banned]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  end
  index do
    column :id
    column :user_name
    column :email_provider do |user|
      user.email.split('@').last.capitalize
    end
    column :tweets do |user|
      user.tweets.count
    end

    column :likes do |user|
      user.likes.count
    end 

    column :follows do |user|
      user.followeds.count
    end 

    column :retweets do |user|
      user.tweets.where('tweet_id IS NOT NULL').count
    end 

    actions
  end 
end