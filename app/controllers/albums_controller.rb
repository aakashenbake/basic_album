class AlbumsController < ApplicationController
  def index
  	@albums = Album.where(:user_id => current_user.id).order(:title)

  end

  def show
  	@album = Album.find(params[:id])
    @picture = Picture.where(:album_id => params[:id]).order(:name)
  end
  
  def edit
  	@album = Album.find(params[:id])
    @picture = Picture.where(:album_id => params[:id]).order(:name)
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
    2.times do
      @album.pictures.build
    end
  end

  def create
    @album = current_user.albums.new(album_params)
    @album.save
  
	  redirect_to albums_path
  end

private
  def album_params
    params.require(:album).permit( :name, :description, pictures_attributes:[:album_id,:name, :description,:image])
  end
end
