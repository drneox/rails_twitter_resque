
# == Schema Information
#
# Table name: posts
#
#  id                 :integer          not null, primary key
#  description        :string(255)
#  image              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  image_fingerprint  :string(255)
#

require 'digest/md5'
require "open-uri"


class Post < ActiveRecord::Base

  before_save  :add_title, :add_slug
	has_attached_file :image, 
	:path => ":rails_root/public/system/:attachment/:id/:basename_:style.:extension",
	:url => "/system/:attachment/:id/:basename_:style.:extension",
	:styles => {
  		:thumb    => ['100x100#',  :jpg, :quality => 70],
  		:preview  => ['480x480#',  :jpg, :quality => 70],
  		:large    => ['600>',      :jpg, :quality => 70],
  		:retina   => ['1200>',     :jpg, :quality => 30]
	},
	:convert_options => {
  		:thumb    => '-set colorspace sRGB -strip',
  		:preview  => '-set colorspace sRGB -strip',
  		:large    => '-set colorspace sRGB -strip',
  		:retina   => '-set colorspace sRGB -strip -sharpen 0x0.5'
	}

  validates :image_fingerprint, uniqueness: true
	validates_attachment :image, content_type: { content_type: /\Aimage\/.*\Z/ }
  
  extend FriendlyId
  friendly_id :slug
  
	def picture_from_url(url)
    	self.image = open(url)
	end

  def add_title
    self.title = self.description.gsub(/\B[@#]\S+\b/, "").gsub(/(?:f|ht)tps?:\/[^\s]+/,"").gsub(/RT/,"").gsub(/:/,"")
  end
  def add_slug
    self.slug = self.title.strip.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end
  #def to_param
  #  	"#{id} #{title}".parameterize
  #end

end
