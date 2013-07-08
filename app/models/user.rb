class User < ActiveRecord::Base
  has_many :tweets
  def fetch_tweets!
    self.tweets.destroy_all
    @tweets = Twitter.user_timeline(self.twitter_username)
    @tweets.each do |tweet|
      Tweet.create(content: tweet.text, user_id: self.id)
    end
  end

  def tweets_stale?
    self.tweets.last.created_at < Time.now - 900
  end
end
