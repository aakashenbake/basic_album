class Picture < ActiveRecord::Base
  	
    acts_as_paranoid

    belongs_to :album
	belongs_to :user
    
    has_and_belongs_to_many :tags
    
    accepts_nested_attributes_for :tags

    has_attached_file :image, styles: { small: "100x100", med: "200x200", large: "300x300" },:path => ":rails_root/public/images/:id/:filename",:url  => "/images/:id/:filename"
    

    validates_attachment_content_type :image ,:content_type => ['image/jpeg', 'image/jpg', 'image/png']
    
    before_save :check_blank_and_tags
    private
        def check_blank_and_tags
            tag_list = self.tags[0].name.to_s.split(',')
            self.tags.destroy_all
            tag_list.each do |obj|
                self.tags.concat(Tag.where(name: obj).first_or_create!)
            end
        end
end