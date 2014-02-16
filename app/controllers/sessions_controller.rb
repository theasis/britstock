class SessionsController < ApplicationController
  skip_before_action :authorize
  def new
    eval(File.open(Rails.root.join('google_config.rb').to_s).read)
    eval(File.open(Rails.root.join('paypal_config.rb').to_s).read)
  end

  def new2
    eval(File.open(Rails.root.join('google_config.rb').to_s).read)
    eval(File.open(Rails.root.join('paypal_config.rb').to_s).read)
  end

  def createpaypal
    require 'net/http'
    require 'uri'
#    require 'paypal-sdk-rest'
    eval(File.open(Rails.root.join('paypal_config.rb').to_s).read)
 #   require 'paypal-sdk/core/openid_connect'
    tokeninfo=nil
    name=nil
    userid=nil
    begin
      code=params[:code] 
      uri = URI.parse("https://api.paypal.com/v1/identity/openidconnect/tokenservice")
      http=Net::HTTP.new(uri.host,uri.port)
      http.use_ssl=true
      http.verify_mode=OpenSSL::SSL::VERIFY_NONE
      request=Net::HTTP::Post.new(uri.request_uri)
      request.basic_auth @paypal_config[:openid_client_id], @paypal_config[:openid_client_secret]
      request.set_form_data("grant_type"=>"authorization_code", "code"=>code, "redirect_uri"=>@paypal_config[:openid_redirect_uri])
      response=http.request(request)
#      tokeninfo = PayPal::SDK::OpenIDConnect::Tokeninfo.create(params[:code])
      if response.code=="200"
        pp_hash=JSON.parse response.body
	uri=URI.parse("https://api.paypal.com/v1/identity/openidconnect/userinfo/?schema=openid")
        http=Net::HTTP.new(uri.host,uri.port)
	http.use_ssl=true
	http.verify_mode=OpenSSL::SSL::VERIFY_NONE
        request=Net::HTTP::Get.new(uri.request_uri)
#	request.basic_auth @paypal_config[:openid_client_id], @paypal_config[:openid_client_secret]
        request["Content-Type"]="application/json"
        request["Authorization"]="Bearer #{pp_hash['access_token']}"
        response=http.request(request)
        if response.code=="200"
          pp_result=JSON.parse response.body
          name=pp_result['name']
          userid=pp_result['user_id']
        end
      end
    rescue PayPal::SDK::Core::Exceptions::BadRequest
      redirect_to "/about/?"+params[:code], alert: "I don't know you!"
      return
    end

#    logger.debug("About to tokeninfo.refresh")
#    tokeninfo.refresh
#    userinfo = tokeninfo.userinfo
#    logger.debug("done")

#    name = userinfo.name
#    userid = userinfo.user_id
    user = Administrator.find_by_gplus(userid)
    if user
      session[:user_id]=user.id
      @fullname = name
      @gplusId = userid

      redirect_to "/success/", notice: "#{@fullname} logged in"
    else
      redirect_to "/useragreement/", alert: "I don't know you!"
    end

  end

  def create
    eval(File.open(Rails.root.join('google_config.rb').to_s).read)
    user = Administrator.find_by_gplus(params[:gplus])
    if user
      session[:user_id]=user.id
      @fullname = params[:fullname]
      @gplusId = params[:gplus]

      redirect_to "/location"
    else
      redirect_to "/location/", alert: "I don't know you!"
    end

  end

  def destroy
    session[:user_id]=nil
    redirect_to "/location/", notice: "#{@fullname} logged out"
  end
end
