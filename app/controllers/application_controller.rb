class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :logged_in, :current_user
  skip_before_filter  :logged_in, :current_user, only: :about

  def about
    
  end

  def dayname(d)
    names = ["Sonntag", "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag"]
    return names[d]
  end

  def admin_only
    unless @current_user.is_admin
      redirect_to root_path, notice: t(:admin_only)
    end
  end

  def bookable_slots(d)
    if Option.where(date: d).first
      Option.where(date: d).first.slots
    elsif d.saturday? || d.sunday?
      return 0
    else
      defaults.slots
    end
  end

  def defaults
    Option.where(date: "0001-01-01").first
  end

  helper_method :dayname, :is_admin, :bookable_slots

  private 
  
  def logged_in
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      redirect_to new_session_url, notice: t(:login_first)
      return false
    end
  end  
  
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

end
