class Album < ActiveRecord::Base
	acts_as_paranoid
	has_many :pictures
	belongs_to :user
	accepts_nested_attributes_for :pictures
	
	validates :name, uniqueness: { scope: :user_id, case_sensitive: false,message: "Album Has already been taken by you"}
end
