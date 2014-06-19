class VotesController < ApplicationController

	def create
    song_url = params[:url]
    user_vote = params[:vote]
    clip = Clip.find_by_clip_link(song_url)
    base_song_url = "https://s3-us-west-1.amazonaws.com/akfoster/users/Music/01-03-+Dirt+and+Roses.mp3"

    if song_url != base_song_url && clip.present?
      if user_vote == 'upvote'
        clip.votes.create!(user_id: current_user.id, like: true)
        render :text => "upvote", layout: false
      elsif user_vote == 'downvote'
        clip.votes.create(user_id: current_user.id, like: false)
        render :text => "downvote", layout: false
      end
    else
      render :text => "error", layout: false
    end
	end
end
