class AlbumsController < ApplicationController
  load_and_authorize_resource :except => :restore
  before_action :album_call, only: [:show, :edit,:destroy,:update,:new,:create]
  
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
  end
  
  def edit
  end
  
  def update
   if @album.update(album_params)
	    	redirect_to @album
	  	else
	    	render 'edit'
	  	end
	end

	def destroy
	  @album.delete
    redirect_to albums_path#
	end
  
  def new
  end

  def create
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
  def album_call
    @album = params[:id].present? ? Album.find(params[:id]) : params[:action]=="create" ? current_user.albums.new(album_params): Album.new
    @picture ||= Picture.where(:album_id => params[:id]).order(:name)
  end
  helper_method :album_call
  def album_params
    params.require(:album).permit( :name, :description, pictures_attributes:[:album_id,:name, :description,:image ,tags_attributes:[:name]])
  end
end
