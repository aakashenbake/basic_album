class Album < ActiveRecord::Migration
  def change
  	create_table(:albums) do |t|
  	t.integer :user_id
  	t.string :title
    t.text :text
    t.timestamps null: false
	end
  end
end
