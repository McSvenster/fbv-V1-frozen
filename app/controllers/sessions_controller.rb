class SessionsController < ApplicationController
  before_action :set_session, only: [:show, :edit, :update]
  skip_before_filter :logged_in 

  def new
    @title = t(:login)
    if @current_user
      redirect_to bookings_url
    end
  end

  def create
    if user = User.where(email: params[:email]).first
      if user && user.authenticate(params[:password]) 
        session[:user_id] = user.id
        @current_user = user
        redirect_to bookings_url
      else
        redirect_to new_session_url, alert: t(:login_failed)
      end
    else
      redirect_to new_session_url, alert: t(:login_failed)
    end
  end

  def destroy
    session[:user_id] = nil
    @current_user = nil
    redirect_to new_session_url, notice: t(:logged_out)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session
      @session = Session.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def session_params
      params[:session]
    end

end
