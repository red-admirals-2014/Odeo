class VotesController < ApplicationController

	def create
    unless params[:url] == "https://srv23.cloudconvert.org/download/i7F82KLc"
      clip = Clip.where(clip_link: params[:url]).first
      if params[:vote] == 'upvote'
        Clip.find_by_clip_link(params[:url]).votes.create(user_id: current_user.id, like: true)
      elsif params[:vote] == 'downvote'
        Clip.find_by_clip_link(params[:url]).votes.create(user_id: current_user.id, like: true)
      else
        render :text => "https://srv23.cloudconvert.org/download/i7F82KLc", layout: false
      end
    end
	end
end