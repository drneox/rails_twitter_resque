#!/usr/bin/env ruby -wKU
require 'uri'
module SearchJob
	#include Resque::Plugins::Status

	#@queque = :search
	def self.queue
        :main
    end
	def self.perform
		$client.search("#chiste pic.twitter", :result_type => "all", :lang => "es").collect do |tweet|
  			image = "#{tweet.media[0].media_url}"
  			description =  tweet.text
        unless image.nil?
    			post = Post.create(:description => description)
    			post.picture_from_url image
    			post.save
        end
  		end
	end
end