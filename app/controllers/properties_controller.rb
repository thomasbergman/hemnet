class PropertiesController < ApplicationController
	def index
		@properties = Property.all
	end
	
	def show
		@property = Property.find(params[:id])
	end

	def new
	end

	def create
		@property = Property.new(property_params)
		@property.parse_url(property_params[:url])
		@property.get_image_from_link(property_params[:url])
		@property.save
		redirect_to properties_path
	end

	def destroy
		@property = Property.find(params[:id])
		@property.destroy

		redirect_to properties_path
	end

private
	def property_params
		params.require(:property).permit(:url, :string)
	end
end
