require 'sinatra'
require 'mini_magick'

get '/*' do
	if request.path_info == '/resizer/display'
		if request.fullpath != request.path_info
			redirect request.fullpath 
		end
	elsif request.path_info == 'resizer/download'
		if request.fullpath != request.path_info	
			redirect request.fullpath 
		end
	end
	send_file File.join('public', 'index.html')
end

get '/resizer/display' do 
	image = MiniMagick::Image.open(params[:url])
	if (params[:height] && params[:width])
		image.resize "#{params[:height]}x#{params[:width]}"
		send_file image.path, :type => image.mime_type
	end
end

get '/resizer/download' do
	image = MiniMagick::Image.open(params[:url])
	if (params[:height] && params[:width])
		image.resize "#{params[:height]}x#{params[:width]}"
		f = File.new(image.path)
		response.headers['content-type'] = "application/octet-stream"
		attachment("resized-image.#{image.mime_type.split('/')[1]}")
		response.write(f)
	end
end