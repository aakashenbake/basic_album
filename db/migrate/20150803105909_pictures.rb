class Pictures < ActiveRecord::Migration
    def change
	  	create_table(:pictures) do |t|
	  	t.integer :user_id
	  	t.integer :album_id
	end
  end
end
