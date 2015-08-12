class AddPicturesToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :picture, :json
  end
end
