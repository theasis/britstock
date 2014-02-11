class SessionsController < ApplicationController
  skip_before_action :authorize
  def new
    eval(File.open('/web/www.focalhero.co.uk/britstock/google_config.rb').read)
    eval(File.open('/web/www.focalhero.co.uk/britstock/paypal_config.rb').read)
  end

  def createpaypal
    require 'paypal-sdk-rest'
    eval(File.open('/web/www.focalhero.co.uk/britstock/paypal_config.rb').read)
    require 'paypal-sdk/core/openid_connect'
    begin
      tokeninfo = PayPal::SDK::OpenIDConnect::Tokeninfo.create(params[:code])
    rescue PayPal::SDK::Core::Exceptions::BadRequest
      redirect_to "/location/", alert: "I don't know you!"
      return
    end

    tokeninfo.refresh
    userinfo = tokeninfo.userinfo

    name = userinfo.name
    userid = userinfo.user_id
    user = Administrator.find_by_gplus(userid)
    if user
      session[:user_id]=user.id
      @fullname = name
      @gplusId = userid

      redirect_to "/location/", notice: "#{@fullname} logged in"
    else
      redirect_to "/location/", alert: "I don't know you!"
    end

  end

  def create
    eval(File.open('/web/www.focalhero.co.uk/britstock/google_config.rb').read)
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
