require 'spec_helper'

describe Clip do

  before (:each) do
    @new_clip = Clip.create(user_id: 1, clip_link: "https://test.example.org")
    fake_user = User.create
    User.stub(:from_omniauth).and_return( fake_user)
  end

   it { should belong_to(:user) }
   it { should have_many(:votes) }

   it "should not add https:// if it already exists in the clip_link" do
    clip = Clip.create(user_id: 1, clip_link: "https://test.org")
    expect(clip.clip_link).to eq("https://test.org")
   end

   it "should add https:// if it does not exist in the clip_link" do
    clip = Clip.create(user_id: 1, clip_link: "//test.org")
    expect(clip.clip_link).to eq("https://test.org")
   end

   it "should get the link for the next song when the first song plays" do
    facebook_auth = {"provider" => "facebook", "uid" => "asfd", "info" => { "email" => "test.example.com", "name" => "tester"}}
    user = User.from_omniauth(facebook_auth)
    next_clip = Clip.get_next_clip(user, "https://srv23.cloudconvert.org/download/i7F82KLc")
    expect(next_clip).to eq(@new_clip.clip_link)
   end

   it "should get the link for the next song when any song" do
    facebook_auth = {"provider" => "facebook", "uid" => "asfd", "info" => { "email" => "test.example.com", "name" => "tester"}}
    user = User.from_omniauth(facebook_auth)
    next_clip = Clip.get_next_clip(user, "https://example.test.com")
    expect(next_clip).to eq(@new_clip.clip_link)
   end

   xit "should end the player when all of the songs have been voted on" do
    facebook_auth = {"provider" => "facebook", "uid" => "asfd", "info" => { "email" => "test.example.com", "name" => "tester"}}
    user = User.from_omniauth(facebook_auth)
    next_clip = Clip.get_next_clip(user, "https://srv23.cloudconvert.org/download/i7F82KLc")
    another_clip = Clip.get_next_clip(user, "https://test.example.org")
    clip = Clip.get_next_clip(user, "https://example.org")
    expect(clip).to eq("end")
   end

   after (:each) do
    Clip.destroy_all
  end
  
end