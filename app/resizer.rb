require 'sinatra'
require 'mini_magick'

get '/*' do
	if request.path_info !~ /(download|display)/
		send_file File.join('public', 'index.html')
	else
		pass
	end
end

get %r{/(download|display)} do
	if /display/.match(request.path_info)
		image = MiniMagick::Image.open(params[:url])
		if (params[:height] && params[:width])
			image.resize "#{params[:height]}x#{params[:width]}"
			send_file image.path, :type => image.mime_type
		end
	elsif /download/.match(request.path_info)
		image = MiniMagick::Image.open(params[:url])
		if (params[:height] && params[:width])
			image.resize "#{params[:height]}x#{params[:width]}"
			f = File.new(image.path)
			response.headers['content-type'] = "application/octet-stream"
			attachment("resized-image.#{image.mime_type.split('/')[1]}")
			response.write(f)
		end
	end
end