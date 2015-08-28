class Album < ActiveRecord::Base
	acts_as_paranoid
	has_many :pictures
	belongs_to :user
	
	accepts_nested_attributes_for :pictures

end
