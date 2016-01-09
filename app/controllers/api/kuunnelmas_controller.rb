class Api::KuunnelmasController < ApplicationController
	skip_before_action :verify_authenticity_token

	private def kuunnelma_params
	    params.require(:kuunnelma).permit(:name, :author, :composer)
	end

	def filter

		p params

		selected_tags = {}
		selected_tags = params[:selected_tags] if params.has_key?(:selected_tags)

		if (0 ==selected_tags.length)
			selected_tags = Tag.all.pluck("id")
		end

		@kuunnelmas =Kuunnelma.where("id in (?)", Kuunnelmatag.where("tag_id in(?)", selected_tags).uniq.pluck("kuunnelma_id"))

		render :partial => 'filter', :content_type => 'text/html'
	end

	def index
		@kuunnelmas =Kuunnelma.all
	end

	def search
		@kuunnelmas =Kuunnelma.all

		respond_to do |format|
			format.html
			format.json { render json: @kuunnelmas }
			format.xml { render xml: @kuunnelmas }
		end
	end

	def tags
		@tags =Kuunnelma.find_by_id(params[:id]).kuunnelmatags.all

		respond_to do |format|
			format.json { render json: @tags }
			format.xml { render xml: @tags }
		end
	end

	def show
		@kuunnelma = Kuunnelma.find_by_id(params[:id])

		respond_to do |format|
			format.html
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
