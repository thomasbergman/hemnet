class Property < ActiveRecord::Base

require 'open-uri'
require 'nokogiri'

has_attached_file :image
validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
	
	def parse_url(url)
		page = Nokogiri::HTML(open(url))

		self.address = page.css('h1').text
		self.price = (page.css("span[class=price]").text.strip.gsub(/[^\d]/, ''))
		apt_info = page.css("dl[class=attributes]").css("dd")
			self.area = apt_info[1].text.gsub(/[^\d]/, '')
			self.no_of_rooms = apt_info[2].text.gsub(/[^\d]/, '')
			self.fee = apt_info[3].text.gsub(/[^\d]/, '')
			self.price_per_sqm = apt_info[4].text.gsub(/[^\d]/, '')

      #Parse showtime dates and time
      date_details1 = page.xpath('.//time')[0].attributes()
      date_string1 = date_details1['datetime'].value()
      self.showtime1 = DateTime.parse(date_string1) + 2.hours #creates a time object + adjusts from UTC to CET +2h
      self.showtime1_start = page.xpath('.//time')[0].inner_text.strip()[-11..-7].to_time + 2.hours
      self.showtime1_end = page.xpath('.//time')[0].inner_text.strip.last(5).to_time + 2.hours
      self.showtime1_duration = TimeDifference.between(self.showtime1_start, self.showtime1_end).in_minutes

      date_details2 = page.xpath('.//time')[1].attributes()
      date_string2 = date_details2['datetime'].value()
      self.showtime2 = DateTime.parse(date_string2) + 2.hours #creates a time object + adjusts from UTC to CET +2h
      self.showtime2_start = page.xpath('.//time')[1].inner_text.strip()[-11..-7].to_time + 2.hours
      self.showtime2_end = page.xpath('.//time')[1].inner_text.strip.last(5).to_time + 2.hours
      self.showtime2_duration = TimeDifference.between(self.showtime2_start, self.showtime2_end).in_minutes
  end
  
  def get_image_from_link(url)
    page = MetaInspector.new(url)
    
    return unless page.images.best.present?
      open(page.images.best) do |file|
      self.image = file
    end
  end
end