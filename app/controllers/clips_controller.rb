
class ClipsController < ApplicationController
  include HTTParty

  def index
    @response = HTTParty.post("https://api.cloudconvert.org/process?apikey=#{ENV['CLOUD_API_KEY']}&inputformat=wav&outputformat=mp3")
    puts @response['url']
  end

  # def new
  # end

  # def upload
  #   uploaded_io = params[:clip][:audio]
  #   File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
  #     HTTParty.post()
  #   end
  # end

end