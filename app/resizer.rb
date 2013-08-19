require 'sinatra'
require 'mini_magick'

get '/*' do
	if request.path_info !~ /^\/(download|display|favicon)/
		send_file File.join('public', 'index.html')
	elsif request.fullpath =~ /(\.gif)/
		send_file File.join('public', 'error.html')
	else
		pass
	end
end

not_found do
	send_file File.join('public', 'error.html')
end

error do
	send_file File.join('public', 'error.html')
end

get '/favicon' do
	send_file File.join('public', 'favicon.ico')
end

get %r{/(download|display)} do
	file_formats = ['bmp', 'png', 'jpeg', 'jpg', 'tiff', 'png', 'tga']
	if /display/.match(request.path_info)
		image = MiniMagick::Image.open(params[:url])
		puts image.mime_type.split('/')[1]
		if file_formats.include? image.mime_type.split('/')[1]
			if (params[:height] && params[:width])
				image.resize "#{params[:height]}x#{params[:width]}"
				send_file image.path, :type => image.mime_type
				send_file File.join('public', 'index.html')
			end
		else
			puts "File format not supported"
			send_file File.join('public', 'error.html')
		end
	elsif /download/.match(request.path_info)
		image = MiniMagick::Image.open(params[:url])
		if file_formats.include? image.mime_type.split('/')[1]
			if (params[:height] && params[:width])
				image.resize "#{params[:height]}x#{params[:width]}"
				f = File.new(image.path)
				response.headers['content-type'] = "application/octet-stream"
				attachment("resized-image.#{Time.now.utc.to_i}.#{image.mime_type.split('/')[1]}")
				response.write(f)
			else
				puts "File format not supported"
				send_file File.join('public', 'error.html')
			end
		end
	end
end

