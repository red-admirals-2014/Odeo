require 'spec_helper'

describe VotesController do
  describe "create" do

    it "renders error when the current song matches the default base_song " do
      post :create, {song_url: "https://s3-us-west-1.amazonaws.com/akfoster/users/Music/01-03-+Dirt+and+Roses.mp3" }
      expect(response.body).to eq("error")
    end

    it "renders error when there are no more clips to choose from" do
      post :create, {clip: nil}
      expect(response.body).to eq("error")
    end

    it "creates an upvote if the user_vote is equal to 'upvote' " do
      User.create
      @clip = Clip.create(user_id: 1, clip_link: "tommy.com")
      post :create, {user_vote: 'upvote', user_id: 1, clip: @clip, song_url: "bob.com"}
      expect(@clip.votes.count).to eq(1)

    end

    it "creates a downvote if the user_vote is equal to 'downvote' " do

    end

  end
end
