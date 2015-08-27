class AlbumsController < ApplicationController
  # load_and_authorize_resource
  before_filter :authenticate_user!
  debugger
  def index
    if (current_user.present?)
  	    if (current_user.roll == "admin")
          @albums = Album.all
          @albums_deleted = Album.only_deleted
        else
          @albums = Album.where(:user_id => current_user.id)
          @albums_deleted = Album.where(:user_id => current_user.id).only_deleted
        end
    else
      redirect_to new_user_session_path
    end
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
	  Album.find(params[:id]).delete
	  redirect_to albums_path
	end
  
  def new
  	@album = Album.new
  end

  def create
    @album = current_user.albums.new(album_params)
    if @album.save
      redirect_to albums_path
    else
      render @album.errors
    end
  end

  def restore
    Album.only_deleted.restore(params[:id])
    redirect_to albums_path
  end

private
  def album_params
    params.require(:album).permit( :name, :description, pictures_attributes:[:album_id,:name, :description,:image ,tags_attributes:[:name]])
  end
end
