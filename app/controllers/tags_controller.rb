class TagsController < ApplicationController
	def show
		@picture = Tag.find(params[:id]).pictures
	end
end
