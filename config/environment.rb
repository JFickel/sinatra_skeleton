# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'

require 'sinatra'
require "sinatra/reloader" if development?

require 'erb'
require 'twitter'
require 'debugger'

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

Twitter.configure do |config|
  config.consumer_key = "QuBRQg9sErUzsHs4E1gSZg"
  config.consumer_secret = "6RV11fJd7OhfGKLkFSITJVIvcLUxep5qG9luUbfNi8"
  config.oauth_token = "22206843-2JJDCUU1T3LtnpubHdkWwAioZHFp2tqYcFMChIuJE"
  config.oauth_token_secret = "pwPYhMlDdOCFijZ9n4q1KxjLAEKPSCQMb27Y2Q4b458"
end

# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

# Set up the database and models
require APP_ROOT.join('config', 'database')


