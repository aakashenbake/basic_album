class AddInformationToAlbumAndPicture < ActiveRecord::Migration
  def change
  	add_column :pictures, :name, :string
  	add_column :albums, :name, :string
  	add_column :pictures, :description, :string
  	add_column :albums, :description, :string
  end
end
