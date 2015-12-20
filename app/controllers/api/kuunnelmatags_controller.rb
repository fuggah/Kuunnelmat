class Api::KuunnelmatagsController < ApplicationController
	skip_before_action :verify_authenticity_token

	private def kuunnelmatag_params
	    params.require(:kuunnelmatag).permit(:tag, :kuunnelma)
	end

	def index
		@kuunnelmatags = Kuunnelmatag.all

		respond_to do |format|
			format.json { render json: @kuunnelmatags }
			format.xml { render xml: @kuunnelmatags }
		end
	end

	def show
		@kuunnelmatag = Kuunnelmatag.find_by_id(params[:id])
		
		respond_to do |format|
			format.json { render json: @kuunnelmatag }
			format.xml { render xml: @kuunnelmatag }
		end
	end

	def delete
		@kuunnelmatag =Kuunnelmatag.find_by_id(params[:id])
		if @kuunnelmatag
			respond_to do |format|
				if @kuunnelmatag.delete
					format.json { render json: @kuunnelmatag, status: :deleted }
					format.xml { render xml: @kuunnelmatag, status: :deleted }
				else
					format.json { render json: @kuunnelmatag.errors, status: :unprocessable_entity }
					format.xml { render xml: @kuunnelmatag.errors, status: :unprocessable_entity }
				end
			end
		else
			respond_to do |format|
				format.json { head :no_content, status: :notfound }
				format.xml { head :no_content, status: :notfound }
			end
		end
	end

	def create
		@kuunnelma =Kuunnelma.find_by_id(kuunnelmatag_params[:kuunnelma])
		@tag =Tag.find_by_id(kuunnelmatag_params[:tag])
		
		if @kuunnelma && @tag
			@kuunnelmatag = Kuunnelmatag.new( { "tag":@tag, "kuunnelma":@kuunnelma })

			respond_to do |format|
				if @kuunnelmatag.save
					format.json { render json: @kuunnelmatag, status: :created }
					format.xml { render xml: @kuunnelmatag, status: :created }
				else
					format.json { render json: @kuunnelmatag.errors, status: :unprocessable_entity }
					format.xml { render xml: @kuunnelmatag.errors, status: :unprocessable_entity }
				end
			end
		else
			respond_to do |format|
				format.json { head :no_content, status: :notfound }
				format.xml { head :no_content, status: :notfound }
			end
		end
	end

	def update
		@kuunnelmatag =Kuunnelmatag.find_by_id(params[:id])
		
		respond_to do |format|
			if @kuunnelmatag.update_attributes(kuunnelmatag_params)
				format.json { head :no_content, status: :ok }
				format.xml { head :no_content, status: :ok }
			else
				format.json { render json: @kuunnelmatag.errors, status: :unprocessable_entity }
				format.xml { render xml: @kuunnelmatag.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@kuunnelmatag =Kuunnelmatag.find_by_id(params[:id])
		
		respond_to do |format|
			if @kuunnelmatag.destroy
				format.json { head :no_content, status: :ok }
				format.xml { head :no_content, status: :ok }
			else
				format.json { render json: @kuunnelmatag.errors, status: :unprocessable_entity }
				format.xml { render xml: @kuunnelmatag.errors, status: :unprocessable_entity }
			end
		end
	end
end
