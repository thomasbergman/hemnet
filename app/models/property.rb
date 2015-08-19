class Property < ActiveRecord::Base

require 'open-uri'
require 'nokogiri'

has_attached_file :image
validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
attr_accessible :image_file_name

#before_save :get_image_from_link
	
	def parse_url(url)
		page = Nokogiri::HTML(open(url))

		self.address = page.css('h1').text
		self.price = page.css("span[class=price]").text.strip
		apt_info = page.css("dl[class=attributes]").css("dd")
			self.area = apt_info[1].text
			self.no_of_rooms = apt_info[2].text
			self.fee = apt_info[3].text
			self.price_per_sqm = apt_info[4].text
	end
  
  def get_image_from_link(url)
    page = MetaInspector.new(url)
    
    return unless page.images.best.present?

    open(page.images.best) do |file|
      self.image = file
    end
  end
end