class Album < ActiveRecord::Base
	has_many :pictures, dependent: :destroy
	belongs_to :user

	accepts_nested_attributes_for :pictures
end
