class Tag < ActiveRecord::Base

	has_many :pictures
	def tag_list
	  self.tags.map { |t| t.name }.join(", ")
	end
	 
	def tag_list=(new_value)
	  tag_names = new_value.split(/,\s+/)
	  self.tags = tag_names.map { |name| Tag.where('name = ?', name).first or Tag.create(:name => name) }
	end

end
