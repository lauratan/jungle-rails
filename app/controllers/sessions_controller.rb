class SessionsController < ApplicationController
  # before_filter :authorize, :except =>[:new]
    def new
    end
  
    def create
        # user = User.find_by_email(params[:email])
        # # If the user exists AND the password entered is correct.
        # if user && user.authenticate(params[:password])
        #   # Save the user id inside the browser cookie. This is how we keep the user 
        #   # logged in when they navigate around our website.
        #   session[:user_id] = user.id
        #   redirect_to '/'
        # else
        # # If user's login doesn't work, send them back to the login form.
        #   redirect_to '/sessions/new'
        # end
        user = User.find_by_email(params[:email].downcase.strip)
        if user && user.authenticate_with_credentials(params[:email].downcase.strip, params[:password])
          # success logic, log them in
          session[:user_id] = user.id
          redirect_to '/'
        else
          # failure, render login form
          redirect_to '/sessions/new'
        end
      end
    
      def destroy
        session[:user_id] = nil
        redirect_to '/sessions/new'
      end
end
