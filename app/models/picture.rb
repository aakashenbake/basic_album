class Picture < ActiveRecord::Base
  	belongs_to :album
	belongs_to :user
    has_many :tags
    
    has_attached_file :image, styles: { small: "100x100", med: "200x200", large: "300x300" },:path => ":rails_root/public/images/:id/:filename",:url  => "/images/:id/:filename"
    
   # validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
    
    validates :image, :presence => true
    #has_attached_file :picture , styles: { small: "100x100", med: "200x200", large: "300x300" }#,:path => ":rails_root/public/images/:id/:filename",:url  => "/images/:id/:filename"
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
    
    # do_not_validate_attachment_file_type :image
end