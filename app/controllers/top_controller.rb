# coding: utf-8
class TopController < ApplicationController

  #-------#
  # index #
  #-------#
  def index
    Tweet.get_tweet( current_user ) unless session[:user_id].blank?
    print "[ Tweet.count ] : " ; p Tweet.count ;

    @tweets = Tweet.all
    print "[ @tweets.class.name ] : " ; p @tweets.class.name ;
    print "[ @tweets.class.name ] : " ; p @tweets.all.class.name ;
#    print "[ @tweets.class.name ] : " ; p @tweets.length ;

    # @tweet = Tweet.all[0]
    # print "[ @tweet.class.name ] : " ; p @tweet.class.name ;

    @tweets = Tweet.limit(10).all
    print "[ @tweets.class.name ] : " ; p @tweets.class.name ;

    @tweets = Tweet.where( id_str: "223489010612441088" )
    print "[ @tweets.class.name ] : " ; p @tweets.class.name ;
    @tweets = @tweets.all
    print "[ @tweets.class.name ] : " ; p @tweets.class.name ;

    @tweets = Tweet.all
    print "[ @tweets.class.name ] : " ; p @tweets.class.name ;

#    @tweets = (Tweet.count > 0) ? Tweet.all : nil
#    print "[ Tweet.class.name ] : " ; p Tweet.class.name ;
    # print "[ @tweets ] : " ; p @tweets ;
    print "[ @tweets ] : " ; p @tweets ;
#    @tweets = @tweets.to_a
#    print "[ @tweets ] : " ; p @tweets ;
    print "[ @tweets.class.name ] : " ; p @tweets.class.name ;
#    print "[ nil.to_a ] : " ; p nil.to_a ;
  end

end
