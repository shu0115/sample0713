# coding: utf-8
class TopController < ApplicationController

  #-------#
  # index #
  #-------#
  def index
    Tweet.get_tweet( current_user ) unless session[:user_id].blank?
    @count = Tweet.count

    @tweets = Tweet.order_by( :tweet_at => :desc ).limit(100).all
  end

end
