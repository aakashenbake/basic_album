class AlbumsController < ApplicationController
  def index
  	@albums = Album.where(:user_id => current_user.id)
  end

  def show
  	@album = Album.find(params[:id])
  end
  
  def edit
  	@album = Album.find(params[:id])
  end
  def update
	@album = Album.find(params[:id])
		if @album.update(album_params)
	    	redirect_to @album
	  	else
	    	render 'edit'
	  	end
	end

	def destroy
	  @album = Album.find(params[:id])
	  @album.destroy
	 
	  redirect_to albums_path
	end
  def new
  	@album = Album.new
  end
  
  def create
  	@album = current_user.albums.new(album_params)
	@album.save
  
	redirect_to @album
  end
private
  def album_params
    params.require(:album).permit( :name, :description)
  end
end
