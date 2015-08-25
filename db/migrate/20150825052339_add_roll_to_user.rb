class AddRollToUser < ActiveRecord::Migration
  def change
  	add_column :users, :roll, :string, default: "client"

  end
end
