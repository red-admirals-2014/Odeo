require 'spec_helper'

describe Clip do
   it { should belong_to(:user) }
   it { should have_many(:votes) }

   context "set up link correctly" do

    it "should not add https:// if it already exists in the clip_link" do
      clip = Clip.create(user_id: 1, clip_link: "https://test.org")
      expect(clip.clip_link).to eq("https://test.org")
    end

    it "should add https:// if it does not exist in the clip_link" do
      clip = Clip.new(user_id: 1, clip_link: "//test.org")
      clip.save
      expect(clip.clip_link).to eq("https://test.org")
    end

  end


   context "get links for next song" do

    before (:each) do
      @new_clip = Clip.create(user_id: 1, clip_link: "https://test.example.org")
      fake_user = User.create
      User.stub(:from_omniauth).and_return( fake_user)
      facebook_auth = {"provider" => "facebook", "uid" => "asfd", "info" => { "email" => "test.example.com", "name" => "tester"}}
      @user = User.from_omniauth(facebook_auth)
    end

    it "should get the link for the next song when the first song plays" do
      next_clip = Clip.get_next_clip(@user, "https://s3-us-west-1.amazonaws.com/akfoster/odeo/odeo_intro.mp3")
      expect(next_clip).to eq(@new_clip.clip_link)
    end

    it "should get the link for the next song when any song" do
      next_clip = Clip.get_next_clip(@user, "https://example.test.com")
      expect(next_clip).to eq(@new_clip.clip_link)
    end

    it "should end the player when all of the songs have been voted on" do
      Clip.destroy_all
      clip = Clip.get_next_clip(@user, "https://example.org")
      expect(clip).to eq("end")
    end

    after (:each) do
      Clip.destroy_all
    end

   end

end