class Photo < ActiveRecord::Base

	belongs_to :album

  	has_attached_file :image,
    	:path => ":rails_root/public/images/:id/:filename",
    	:url  => "/images/:id/:filename",
    	styles: { medium: '300x300>', thumb: '1000x1000>' },
    	:processors => [:thumbnail, :compression]

  	do_not_validate_attachment_file_type :image
end
