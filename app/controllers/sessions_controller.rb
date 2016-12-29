class SessionsController < ApplicationController
  def new
  end

  def create
	  user = User.find_by(email: params[:session][:user].downcase)
	  byebug
	  unless user
		  user = User.find_by(username: params[:session][:user])
	  end

	  if user && user.authenticate(params[:session][:password])
		log_in user
		redirect_to user
	  else
		flash.now[:danger] = "Invalid email/password combination"
		render 'new'
	  end
  end

  def destroy
	  log_out
	  redirect_to root_url
  end
end