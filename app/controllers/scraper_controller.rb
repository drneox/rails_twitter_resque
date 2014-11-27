require 'uri'
class ScraperController < ApplicationController
	def index

	# 	$client.search("#chiste pic.twitter", :result_type => "all", :lang => "es").collect do |tweet|
 #  			image = "#{tweet.media[0].media_url}"
 #  			description =  tweet.text
 #  			post = Post.create(:description => description)
 #  			post.picture_from_url image
 #  			post.save
	# 	end
	# 	render json: "hola"

    Resque.enqueue(SearchJob)
    render json: "hola"
	end
  
end
