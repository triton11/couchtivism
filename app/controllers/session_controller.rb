class SessionController < ApplicationController
	def new
		render 'session/new'
	end

	def create
	  @user = User.find_by(email: params[:email])
	  unless @user.nil?
	      if @user.password_hash == params[:password]
	        session[:user_id] = @user.id
	        redirect_to "/"
	      else 
	      	redirect_to '/login'
	      end
      else 
      	redirect_to '/login'
      end
	end

	def destroy
		reset_session
		redirect_to('/')
	end
end
