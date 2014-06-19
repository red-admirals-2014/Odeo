require 'spec_helper'

describe VotesController do
  describe "create" do

    it "renders error when the current song matches the default base_song " do
      post :create, song_url: "https://s3-us-west-1.amazonaws.com/akfoster/odeo/odeo_intro.mp3"
      expect(response.body).to eq("error")
    end

    it "renders error when there are no more clips to choose from" do
      post :create, clip: nil
      expect(response.body).to eq("error")
    end

    it "creates an upvote if the user_vote is equal to 'upvote' " do
      user = User.create( provider: "facebook", uid: "uaf", name: "user1", oauth_token: "kafjkje", oauth_expires_at: Time.now )
      session[:user_id] = user.id
      clip = Clip.create(user_id: 1, clip_link: "//tommy.com" )
      post :create, url: "https://tommy.com", vote: "upvote"
      expect(clip.votes.first.like).to eq(true)
    end

    it "creates a downvote if the user_vote is equal to 'downvote' " do
      user = User.create( provider: "facebook", uid: "uaf", name: "user1", oauth_token: "kafjkje", oauth_expires_at: Time.now )
      session[:user_id] = user.id
      clip = Clip.create(user_id: 1, clip_link: "//tommy.com")
      post :create, url: "https://tommy.com", vote: "downvote"
      expect(clip.votes.first.like).to eq(false)
    end

  end
end
