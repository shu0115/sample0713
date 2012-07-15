# coding: utf-8
class ApplicationController < ActionController::Base

  protect_from_forgery

  # httpsリダイレクト
  before_filter :ssl_redirect if Rails.env.production?

  # 未ログインリダイレクト
  before_filter :authorize

  # セッション有効期限延長
  before_filter :reset_session_expires

  # Heroku用定期アクセス
#  before_filter :heroku_periodic_access if Rails.env.production?
  before_filter :heroku_periodic_access

  private

  #--------------#
  # ssl_redirect #
  #--------------#
  # httpsへリダイレクト(Production環境のみ)
  def ssl_redirect
    unless request.env["HTTP_X_FORWARDED_PROTO"].to_s == "https"
      request.env["HTTP_X_FORWARDED_PROTO"] = "https"

      redirect_to request.url and return
    end
  end

  #-----------#
  # authorize #
  #-----------#
  # ログイン認証
  def authorize
    # セッション／トップコントローラ以外で
    if params[:controller] != "sessions" and params[:controller] != "top"
      # 未ログインであればルートヘリダイレクト
      if session[:user_id].blank?
        redirect_to :root and return
      end
    end
  end

  #-----------------------#
  # reset_session_expires #
  #-----------------------#
  # セッション期限延長
  def reset_session_expires
    request.session_options[:expire_after] = 2.weeks
  end

  #------------------------#
  # heroku_periodic_access #
  #------------------------#
  # Heroku用定期アクセス
  $timer_arry = Array.new

  def heroku_periodic_access
    $timer_arry.each{ |timer|
      # タイマーキャンセル
      result = timer.cancel

      # タイマー削除
      if result == true
        $timer_arry.delete( timer )
      end
    }

    EM.run do
      # 1分周期
      result = EM.add_periodic_timer(10) do
        puts "[ ----- #{Time.now.strftime("%Y/%m/%d %H:%M:%S")} Lengthen... ----- ]"
#        url = "https://sample0713.herokuapp.com/"
        url = "http://www.yahoo.co.jp/"
#        parsed_url = URI.parse( url_for(:root) )
        parsed_url = URI.parse( url )
        http = Net::HTTP.new( parsed_url.host, parsed_url.port )
        print "[ url.index ] : " ; p url.index("https:") ;
        if url.index("https:") == 0
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
        request = Net::HTTP::Get.new( parsed_url.request_uri )
        response = http.request( request )
        print "[ response ] : " ; p response ;
        puts "[ ------------------------------------------- ]"
      end

      # タイマー保管
      $timer_arry.push( result )
    end
  end

  #--------------#
  # current_user #
  #--------------#
  def current_user
    @current_user ||= User.where( id: session[:user_id] ).first
  end

  helper_method :current_user

end
