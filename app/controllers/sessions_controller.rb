class SessionsController < ApplicationController
  # before_filter :authorize, :except =>[:new]
    def new
    end
  
    def create
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
