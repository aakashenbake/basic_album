class Picture < ActiveRecord::Base
  	belongs_to :album
	belongs_to :user

    # acts_as_taggable_on :tags
    
    has_and_belongs_to_many :tags
    
    accepts_nested_attributes_for :tags

    has_attached_file :image, styles: { small: "100x100", med: "200x200", large: "300x300" },:path => ":rails_root/public/images/:id/:filename",:url  => "/images/:id/:filename"
    
    validates :image, :presence => true

    validates_attachment_content_type :image ,:content_type => ['image/jpeg', 'image/jpg', 'image/png']
    
    before_save :check_tag

    def check_tag
        tag_list = self.tags[0].name.to_s.split(',')
        self.tags.destroy_all
        tag_list.each do |obj|
            self.tags.concat(Tag.where(name: obj).first_or_create!)
        end
    end
end