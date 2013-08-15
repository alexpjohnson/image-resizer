require 'sinatra'
require 'mini_magick'

get '/resizer' do 
	url = params[:url]
	puts url
	puts params[:height]
	puts params[:width]
	image = MiniMagick::Image.open(url)
	image.resize "#{params[:height]}x#{params[:width]}"
	image.write "resized-image.png"
		
end