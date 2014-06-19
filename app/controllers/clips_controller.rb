
class ClipsController < ApplicationController
  def index
    @rating = current_user.percent_rating if current_user
  end

  def create
    clip = current_user.clips.new(clip_link: params[:url])

    if clip.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def next
    next_clip_link = Clip.get_next_clip(current_user, params[:url])
    if next_clip_link == "end"
      render :text => "end"
    else
      render :text => next_clip_link
    end
  end
end