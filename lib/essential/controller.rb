module Essential
  class Controller < ActionController::Base
    include Apotomo::Rails::ControllerMethods

    helper Essential::Engine.helpers
    # helper FontAwesome::Rails::IconHelper

    layout :set_layout

    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    before_filter :authenticate unless %w(sessions passwords invitations).include?(controller_name)

    # Get the previous url and set it as a helper
    def previous_url
      url = session[:redirect_url] ||= root_path
      session[:redirect_url] = nil
      url
    end
    helper_method :previous_url

    def set_layout
      if user_signed_in?
        "application"
      else
        "login"
      end
    end

    protected

    def authenticate
      unless %w(sessions passwords invitations).include?(controller_name)
        if !current_user.respond_to? :id
          store_location
          redirect_to '/login'
        end
      end
    end

    def store_location
       # store last url - this is needed for post-login redirect to whatever the user last visited.
      if (request.fullpath != "/users/sign_in" && \
          request.fullpath != "/logout" && \
          request.fullpath != "/login" && \
          !request.xhr?) # don't store ajax calls
        session[:previous_url] = request.fullpath
      end
    end
  end
end
