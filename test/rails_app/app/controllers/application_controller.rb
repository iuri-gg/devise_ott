class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_user, :unless => :devise_controller?
  before_filter :authenticate_user!, :if => :devise_controller?
  respond_to *Mime::SET.map(&:to_sym)
end