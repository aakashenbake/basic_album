class AddInfoToTags < ActiveRecord::Migration
  def change
  	add_column :tags, :picture_id, :integer
  end
end
