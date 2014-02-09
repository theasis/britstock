class SessionsController < ApplicationController
  skip_before_action :authorize
  def new
    eval(File.open('/web/www.theasis.co.uk/BritishStock/britstock/google_config.rb').read)
    eval(File.open('/web/www.theasis.co.uk/BritishStock/britstock/paypal_config.rb').read)
  end

  def createpaypal
    require 'paypal-sdk-rest'
    eval(File.open('/web/www.theasis.co.uk/BritishStock/britstock/paypal_config.rb').read)

#    include PayPal::SDK::REST
    PayPal::SDK.configure({
      :mode => "live",
      :openid_client_id => @paypal_config[:openid_client_id],
      :openid_client_secret => @paypal_config[:openid_client_secret],
      :openid_redirect_uri => @paypal_config[:openid_redirect_uri]
    })

    require 'paypal-sdk/core/openid_connect'
    tokeninfo = PayPal::SDK::OpenIDConnect::Tokeninfo.create(params[:code])
    tokeninfo.refresh
    userinfo = tokeninfo.userinfo

    name = userinfo.name
    userid = userinfo.user_id

    u = Administrator.new(:name => name, :gplus => userid)
    u.save

    redirect_to "/BritStock/admindone"

  end

  def create
    eval(File.open('/web/www.theasis.co.uk/BritishStock/britstock/google_config.rb').read)
    user = Administrator.find_by_gplus(params[:gplus])
    if user
      session[:user_id]=user.id
      @fullname = params[:fullname]
      @gplusId = params[:gplus]

      redirect_to "/BritStock/location/", notice: "#{@fullname} logged in"
    else
      redirect_to "/BritStock/location/", alert: "I don't know you!"
    end

  end

  def destroy
    session[:user_id]=nil
    redirect_to "/BritStock/location/", notice: "#{@fullname} logged out"
  end
end
