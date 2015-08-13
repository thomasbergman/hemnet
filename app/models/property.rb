class Property < ActiveRecord::Base

require 'open-uri'
require 'nokogiri'

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
end