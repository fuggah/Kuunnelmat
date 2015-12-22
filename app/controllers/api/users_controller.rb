class Api::UsersController < ApplicationController
#	http_basic_authenticate_with :name => "myfinance", :password => "credit123"

#	skip_before_filter :authenticate_user! # we do not need devise authentication here
#	before_filter :fetch_user, :except => [:index, :create]
	skip_before_action :verify_authenticity_token
	
	private def user_params
	    params.require(:user).permit(:email, :firstname, :lastname, :password, :nickname, :confirmation )
	end

	def index
		@users = User.all

		respond_to do |format|
			format.json { render json: @users }
			format.xml { render xml: @users }
		end
	end

	def show
		@user = User.find_by_id(params[:id])
		
		respond_to do |format|
			format.json { render json: @user }
			format.xml { render xml: @user }
		end
	end

	def create
		@user = User.new(user_params)
		@user.temp_password = Devise.friendly_token

		respond_to do |format|
			if @user.save
				format.json { render json: @user, status: :created }
				format.xml { render xml: @user, status: :created }
			else
				format.json { render json: @user.errors, status: :unprocessable_entity }
				format.xml { render xml: @user.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		@user =User.find_by_id(params[:id])
		
		respond_to do |format|
			if @user.update_attributes(user_params)
				format.json { head :no_content, status: :ok }
				format.xml { head :no_content, status: :ok }
			else
				format.json { render json: @user.errors, status: :unprocessable_entity }
				format.xml { render xml: @user.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		respond_to do |format|
			if @user.destroy
				format.json { head :no_content, status: :ok }
				format.xml { head :no_content, status: :ok }
			else
				format.json { render json: @user.errors, status: :unprocessable_entity }
				format.xml { render xml: @user.errors, status: :unprocessable_entity }
			end
		end
	end
end
