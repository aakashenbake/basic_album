class PicturesController < ApplicationController
 def index
 	@picture = Picture.where(:album_id => params[:album_id])
 end
 
 def new
   @picture = Picture.new(:album_id => params[:album_id])
 end
 
 def create
  @picture = current_user.pictures.new(picture_params)
  
  @picture.save
  redirect_to album_pictures_path
 end
 
 def show
  	@picture = Picture.find(params[:id])

 end
 
 def edit
  	@picture = Picture.find(params[:id])
 end
 
 def update
	@picture = Picture.find(params[:id])
		if @picture.update(picture_params)
	    	redirect_to album_pictures_path
	  	else
	    	render 'edit'
	  	end
	end

 def destroy
  @picture = Picture.find(params[:id])
  album_id = @picture.album_id
  @picture.destroy
  redirect_to album_path(album_id)
 end

 private
 
  def picture_params
    params.require(:picture).permit(:name,:album_id, :description,:image, :all_tags)
  end

end
