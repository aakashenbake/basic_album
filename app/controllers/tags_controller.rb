class TagsController < ApplicationController
	def show
		@picture = Tag.find(params[:id]).pictures.page(params[:page])
	end
end
