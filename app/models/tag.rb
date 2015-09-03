class Tag < ActiveRecord::Base
	has_and_belongs_to_many :pictures
	max_paginates_per 10
end
