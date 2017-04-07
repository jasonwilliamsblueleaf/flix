class SessionsController < ApplicationController
	def new
		
	end

	def create
		if user = User.authenticate(params[:username], params[:password])
			session[:user_id] = user.id
			flash[:notice] = "Welcome back, #{user.name}!"
			redirect_to(session[:intended_url] || user)
			session[:intended_url] = nil
		else
			flash.now[:alert] = "Invalid username/password combination!"
			render :new
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url, notice: "You're successfully signed out"
	end
end
