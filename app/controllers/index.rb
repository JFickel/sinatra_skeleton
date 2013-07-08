# get '/' do
#   # Look in app/views/index.erb
#   @twitter = Twitter.user_timeline("180AD")
#   erb :index
# end


get '/:twitter_username/user_tweets' do
  @user = User.find_or_create_by_twitter_username(params[:twitter_username])
  #load page
  erb :user_tweets
end

post '/retrieve_tweets' do
  @user = User.find_or_create_by_twitter_username(params[:twitter_username])
  @tweets = @user.fetch_tweets!
  erb :_tweet_partial
end

get '/:twitter_username' do
  @user = User.find_or_create_by_twitter_username(params[:twitter_username])
  if @user.tweets.empty? || @user.tweets_stale?
    # User#fetch_tweets! should make an API call
    # and populate the tweets table
    #
    redirect ("/" + @user.twitter_username + "/user_tweets")
  end

  @tweets = @user.tweets.limit(10)
  erb :index
end
