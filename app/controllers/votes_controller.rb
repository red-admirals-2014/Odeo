class VotesController < ApplicationController

	def create
    song_url = params[:url]
    base_song_url = "https://srv23.cloudconvert.org/download/i7F82KLc"
    user_vote = params[:vote]

    if song_url != base_song_url
      clip = Clip.find_by_clip_link(song_url)
      if user_vote == 'upvote'
        clip.votes.create(user_id: current_user.id, like: true)
      elsif user_vote == 'downvote'
        clip.find_by_clip_link(params[:url]).votes.create(user_id: current_user.id, like: true)
      else
        render :text => base_song_url, layout: false
      end
    else
      render :text => "************* RENDAR ***************", layout: false
    end
	end
end