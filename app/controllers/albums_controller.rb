class AlbumsController < ApplicationController
  load_and_authorize_resource :except => :restore
  before_action :album_call
  skip_before_action :album_call, only:[:restore,:index] 
  def index
    if (current_user.present?)
          album_call
        if (current_user.roll == "admin")
          @albums = Album.all.order(:name).page(params[:page])
          @albums_deleted = Album.only_deleted.order(:name).page(params[:page])
        else
          @albums = Album.where(:user_id => current_user.id).order(:name).page(params[:page])
          @albums_deleted = Album.where(:user_id => current_user.id).only_deleted.order(:name).page(params[:page])
        end
    else
      redirect_to new_user_session_path
    end
  end

  def show
    @tPictures =Picture.where(:album_id => params[:id]).count
  end
  
  def edit
    @picture_new = Picture.new(:album_id => params[:id])
  end
  
  def update
   if @album.update(album_params)
        redirect_to edit_album_path
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
    begin
      if @album.save
        redirect_to albums_path
      else
        render @album.errors
      end
    rescue Exception => e
      flash[:alert]=@album.errors.full_messages.first
      redirect_to root_path 
    end
  end

  def restore
    Album.only_deleted.restore(params[:id])
    redirect_to albums_path
  end
  
private
  def album_call
    @album = params[:id].present? ? Album.find(params[:id]): current_user.albums.new(album_params)
    @picture ||= Picture.where(:album_id => params[:id]).order(:name).page(params[:page])
  end
  helper_method :album_call
  def album_params
    if(params[:album].present?)
      params.require(:album).permit( :name, :description,:delete, pictures_attributes:[:album_id,:name, :description,:image ,tags_attributes:[:name]])
    else
      return nil  
    end
  end
end