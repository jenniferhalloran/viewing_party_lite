class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password]) && user.admin?
      session[:user_id] = user.id
      redirect_to '/admin/dashboard'
    elsif user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/dashboard'
    else
      redirect_to '/login'
      flash[:error] = 'Invalid Credentials, try again.'
    end
  end

  def destroy
    session.destroy
    redirect_to '/'
  end
end
