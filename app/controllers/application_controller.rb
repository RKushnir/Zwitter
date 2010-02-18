# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  include AuthenticatedSystem
  before_filter :login_required
  before_filter :set_time_zone
  before_filter :mailer_set_url_options
  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation

private
  def set_time_zone
    Time.zone = @current_user.time_zone if @current_user
  end
  
  def mailer_set_url_options
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end  
end
