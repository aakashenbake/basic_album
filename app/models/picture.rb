class Picture < ActiveRecord::Base
  	belongs_to :album
	  belongs_to :user
    has_many :tags
    
    accepts_nested_attributes_for :tags

    has_attached_file :image, styles: { small: "100x100", med: "200x200", large: "300x300" },:path => ":rails_root/public/images/:id/:filename",:url  => "/images/:id/:filename"
    
    validates :image, :presence => true

    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
    
    def all_tags=(names)
      self.tags = names.split(",").map do |name|
          Tag.where(name: name.strip).first_or_create!
      end
    end

    def all_tags
      self.tags.map(&:name).join(", ")
    end

end