class Picture < ActiveRecord::Base
  	belongs_to :album
	belongs_to :user
    has_many :tags
    has_attached_file :image, styles: { small: "100x100", med: "200x200", large: "300x300" }
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
    validates :image, :presence => true

   # accepts_nested_attributes_for :pictures, :allow_destroy => true
end