class PicturesController < ApplicationController
 load_and_authorize_resource
 def index
  @picture = Picture.where(:album_id => params[:album_id])
 end
 
 def new
   @picture_new = Picture.new(:album_id => params[:album_id])
 end
 
 def create
  debugger
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
  debugger
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
 
 def destroy_multiple
   if params[:picture_ids].present?
     params[:picture_ids].each do |id|
       Picture.find(id.to_i).destroy
     end
   end
   redirect_to  edit_album_path(params[:album_id])
 end
 private
 
  def picture_params
    params.require(:picture).permit(:name,:album_id, :description,:image,tags_attributes:[:name])
  end

end
