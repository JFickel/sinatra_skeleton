# get '/' do
#   # Look in app/views/index.erb
#   @twitter = Twitter.user_timeline("180AD")
#   erb :index
# end

get '/:twitter_username' do
  @user = User.find_or_create_by_twitter_username(params[:twitter_username])
  if @user.tweets.empty? || @user.tweets_stale?
    # User#fetch_tweets! should make an API call
    # and populate the tweets table
    #
    # Future requests should read from the tweets table 
    # instead of making an API call
    @user.fetch_tweets!
    @message = "just did that shit"
  end

  @tweets = @user.tweets.limit(10)
  erb :index
end