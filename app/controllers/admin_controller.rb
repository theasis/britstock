class AdminController < ApplicationController
  def index
  end

  def new
    user = Administrator.find_by_gplus(params[:gplus])
    if user
      redirect_to "/admin", notice: "User with name #{@fullname} and Google+ ID #{@gplusId} has been successfully registered!"
    else
      @fullname = params[:fullname]
      @gplusId = params[:gplus]
      u = Administrator.new(:name => params[:fullname], :gplus => params[:gplus])
      u.save
      redirect_to "/admin", notice: "User with name #{@fullname} and Google+ ID #{@gplusId} has been successfully registered!"
    end
  end
end
