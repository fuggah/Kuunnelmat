class Api::TagsController < ApplicationController
	skip_before_action :verify_authenticity_token

	private def tag_params
	    params.require(:tag).permit(:tag)
	end

	def index
		@tags = Tag.all

		respond_to do |format|
			format.json { render json: @tags }
			format.xml { render xml: @tags }
		end
	end

	def show
		@tag = Tag.find_by_id(params[:id])
		
		respond_to do |format|
			format.json { render json: @tag }
			format.xml { render xml: @tag }
		end
	end

	def create
		@tag = Tag.new(tag_params)

		respond_to do |format|
			if @tag.save
				format.json { render json: @tag, status: :created }
				format.xml { render xml: @tag, status: :created }
			else
				format.json { render json: @tag.errors, status: :unprocessable_entity }
				format.xml { render xml: @tag.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		@tag =Tag.find_by_id(params[:id])
		
		respond_to do |format|
			if @tag.update_attributes(tag_params)
				format.json { head :no_content, status: :ok }
				format.xml { head :no_content, status: :ok }
			else
				format.json { render json: @tag.errors, status: :unprocessable_entity }
				format.xml { render xml: @tag.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@tag =Tag.find_by_id(params[:id])
		
		respond_to do |format|
			if @tag.destroy
				format.json { head :no_content, status: :ok }
				format.xml { head :no_content, status: :ok }
			else
				format.json { render json: @tag.errors, status: :unprocessable_entity }
				format.xml { render xml: @tag.errors, status: :unprocessable_entity }
			end
		end
	end
end
