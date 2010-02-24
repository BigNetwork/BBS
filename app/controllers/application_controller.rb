# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  include AuthenticatedSystem
  
  before_filter :set_user_language, :check_for_sorting
  
  private
  
    def set_user_language
      I18n.locale = 'sv-SE'
    end
    
    def check_for_sorting
      # Check for sort_how:
      if params[:sort_how].nil?
        @sort_how = 'ASC'
      else  # Flip the coin if we already are sorting in a way:
        if params[:sort_how] == 'asc'
          @sort_how = 'ASC'
        elsif params[:sort_how] == 'desc'
          @sort_how = 'DESC'
        end
      end
      # Check for sort_by:
      if params[:sort_by].nil?
        @sort_by = 'id'
      else
        @sort_by = params[:sort_by] # FIXME, this is a security flaw! Can be used for SQL injections!
      end
    end
    
end
