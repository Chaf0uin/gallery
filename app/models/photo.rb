class Photo < ActiveRecord::Base

	belongs_to :album
  belongs_to :user

  	has_attached_file :image,
    	:path => ":rails_root/public/images/:id/:filename",
    	:url  => "/images/:id/:filename",
    	styles: { thumb: '1000x1000>' },
    	:processors => [:thumbnail, :compression]

  	do_not_validate_attachment_file_type :image

  	has_many :comments

  	def next
    	self.class.where("id > ?", id).where("album_id = ?", album_id).first
  	end

  	def previous
    	self.class.where("id < ?", id).where("album_id = ?", album_id).last
  	end

    
end
