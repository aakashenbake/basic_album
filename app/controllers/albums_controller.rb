class AlbumsController < ApplicationController
  load_and_authorize_resource :except => :restore
  before_action :album_call
  skip_before_action :album_call, only:[:restore,:index] 
  def index
    if (current_user.present?)
          album_call
  	    if (current_user.roll == "admin")
          @albums = Album.all.page(params[:page])
          @albums_deleted = Album.only_deleted.page(params[:page])
        else
          @albums = Album.where(:user_id => current_user.id).page(params[:page])
          @albums_deleted = Album.where(:user_id => current_user.id).only_deleted.page(params[:page])
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
    redirect_to albums_path
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
    # debugger
    @album = params[:id].present? ? Album.find(params[:id]): current_user.albums.new(album_params)
    @picture ||= Picture.where(:album_id => params[:id]).order(:name).page(params[:page])
  end
  helper_method :album_call
  def album_params
      # params.require(:album).permit( :name, :description, pictures_attributes:[:album_id,:name, :description,:image ,tags_attributes:[:name]])
    if(params[:name].present?)
      params.require(:album).permit( :name, :description, pictures_attributes:[:album_id,:name, :description,:image ,tags_attributes:[:name]])
    else
      return nil  
    end
  end
end
