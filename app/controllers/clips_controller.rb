
class ClipsController < ApplicationController
  def index
    if current_user
      @rating = current_user.percent_rating
    end
  end

  def create
    clip = current_user.clips.new(clip_link: params[:url])

    if clip.save && params[:error] == nil
      redirect_to root_path
    else
      # CR Check your json object client side for error from cloudconvert and make sure to send that along so you can actually have a fail .- ie wrap your API calls in a MVC or MC
      puts "This failed"
      redirect_to root_path
    end
  end

  def next
    next_clip_link = Clip.get_next_clip(current_user, params[:url])
    if next_clip_link == "end"
      render :text => "end", layout: false
    else
      render :text => next_clip_link, layout: false
    end
  end

end