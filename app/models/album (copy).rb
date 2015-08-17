class Album < ActiveRecord::Base
	has_many :pictures, dependent: :destroy
	belongs_to :user

	accepts_nested_attributes_for :pictures

	has_attached_file :image, styles: { small: "100x100", med: "200x200", large: "300x300" },:path => ":rails_root/public/images/:id/:filename",:url  => "/images/:id/:filename"
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
    validates :image, :presence => true
    
end
