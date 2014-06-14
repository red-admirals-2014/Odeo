class ClipsController < ApplicationController

  def index
    conversion = Cloudconvert::Conversion.new
    @cloudconvert = conversion.convert('upload', 'mp3', 'https://s3-us-west-1.amazonaws.com/akfoster/users/avatars/000/000/010/original/myRecording00_copy.wav')
  end

end