class ApplicationController < ActionController::Base
    # so I can use these methods in the views 
    helper_method :current_user, :logged_in?

    private
    # I used the name @current_user so nothing get overridden
    # this is called memoization 
    def current_user
        @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id] #=> use if statement so as to not make a call to database, if not necessary
    end

    def logged_in?
        !!session[:user_id] #=> more secure way is if @current_user is truthy
    end

    def redirect_if_not_logged_in
        # maybe display flash message
        redirect_to '/' if !logged_in?
    end

    def set_object(value)
        if !instance_variable_set("@#{controller_name.singularize}", value.find_by(id: params[:id]))
            flash[:message] = "#{controller_name.singularize} was not found"
            redirect_to "/#{controller_name}"
        end
    end
end
