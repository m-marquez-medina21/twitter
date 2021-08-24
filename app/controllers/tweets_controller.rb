class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ show edit update destroy :retweet]

  # GET /tweets or /tweets.json -- paginacion del index se deja en 5 tweets en un inicio para hacer pruebas
  def index
    @user_likes = Like.where(user: current_user).pluck(:tweet_id)
    @tweet = Tweet.new
    @tweets = Tweet.order(:last).page(params[:page]).per(5)
  end

  # GET /tweets/1 or /tweets/1.json
  def show
  end

  # GET /tweets/new -- si el usuario esta logeado, que se cree el tweet, de lo contrario se redirige al iniciar secion
  def new 
    if user_signed_in?
      @tweet = Tweet.new
    else
      redirect_to new_user_session_path
    end 
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets or /tweets.json
  def create
    @tweet = Tweet.new(content: params[:tweet][:content])
    @tweet.user= current_user

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: "Tweet was successfully created." }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1 or /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: "Tweet was successfully updated." }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1 or /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: "Tweet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def retweet
    @tweet = Tweet.find(params[:id])
    new_tweet = Tweet.create(content: @tweet.content, user: current_user)
    @tweet.retweets << new_tweet
    redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:content, :retweet, :rt_ref)
    end
end
