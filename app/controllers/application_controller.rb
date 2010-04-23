# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  helper_method :current_user, :current_user_session
  private
    def current_user_session
      @current_user_session ||= UserSession.find || UserSession.for_new_user
    end

    def current_user
      @current_user ||= current_user_session.user
    end
end
