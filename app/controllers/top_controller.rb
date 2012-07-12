# coding: utf-8
class TopController < ApplicationController

  #-------#
  # index #
  #-------#
  def index
    Tweet.get_tweet( current_user ) unless session[:user_id].blank?
#    print "[ Tweet.count ] : " ; p Tweet.count ;
    @tweets = Tweet.all
#    @tweets = (Tweet.count > 0) ? Tweet.all : nil
    print "[ Tweet.class.name ] : " ; p Tweet.class.name ;
    print "[ @tweets ] : " ; p @tweets ;
    print "[ @tweets.class.name ] : " ; p @tweets.class.name ;
  end

end
