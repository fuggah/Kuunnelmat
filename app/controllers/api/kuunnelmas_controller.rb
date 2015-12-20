class Api::KuunnelmasController < ApplicationController
	skip_before_action :verify_authenticity_token

	private def kuunnelma_params
	    params.require(:kuunnelma).permit(:name, :author, :composer)
	end

	def index
		@kuunnelmas = Kuunnelma.all

		respond_to do |format|
			format.json { render json: @kuunnelmas }
			format.xml { render xml: @kuunnelmas }
		end
	end

	def show
		@kuunnelma = Kuunnelma.find_by_id(params[:id])
#		@kuunnelmatags =@kuunnelma.kuunnelmatags
		
		respond_to do |format|
			format.json { render json: @kuunnelma }
			format.xml { render xml: @kuunnelma }
		end
	end

	def create
		@kuunnelma = Kuunnelma.new(kuunnelma_params)

		respond_to do |format|
			if @kuunnelma.save
				format.json { render json: @kuunnelma, status: :created }
				format.xml { render xml: @kuunnelma, status: :created }
			else
				format.json { render json: @kuunnelma.errors, status: :unprocessable_entity }
				format.xml { render xml: @kuunnelma.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		@kuunnelma =Kuunnelma.find_by_id(params[:id])
		
		respond_to do |format|
			if @kuunnelma.update_attributes(kuunnelma_params)
				format.json { head :no_content, status: :ok }
				format.xml { head :no_content, status: :ok }
			else
				format.json { render json: @kuunnelma.errors, status: :unprocessable_entity }
				format.xml { render xml: @kuunnelma.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@kuunnelma =Kuunnelma.find_by_id(params[:id])
		
		respond_to do |format|
			if @kuunnelma.destroy
				format.json { head :no_content, status: :ok }
				format.xml { head :no_content, status: :ok }
			else
				format.json { render json: @kuunnelma.errors, status: :unprocessable_entity }
				format.xml { render xml: @kuunnelma.errors, status: :unprocessable_entity }
			end
		end
	end
end
