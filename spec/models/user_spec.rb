require 'spec_helper'

describe User do 

  before (:each) do
    fake_user = User.create
    User.stub(:from_omniauth).and_return( fake_user)
    facebook_auth = {"provider" => "facebook", "uid" => "asfd", "info" => { "email" => "test.example.com", "name" => "tester"}}
    @user = User.from_omniauth(facebook_auth)
    @user2 = User.from_omniauth(facebook_auth)
  end

  context "associations" do
    it { should have_many(:clips) }
    it { should have_many(:votes) }
  end

  context "#from_omniauth" do

    it "should create a user given valid facebook information" do
      expect(User.last).to eq(@user)
    end

    it "should return an existing user given valid facebook information" do
      expect(User.find(@user2.id)).to eq(@user)
    end

  end

  context "#percent_rating" do

    it "should return a percent rating of liked clips if over 0" do
      clip1 = Clip.create(user_id: @user.id, clip_link: "https://test.com")
      clip2 = Clip.create(user_id: @user.id, clip_link: "https://test.org")
      vote1 = Vote.create(user_id: @user2.id, clip_id: clip1.id, like: true)
      vote2 = Vote.create(user_id: @user2.id, clip_id: clip2.id, like: false)
      expect(@user.percent_rating).to eq(50)
    end

    it "should return 0 if there are no liked clips" do
      expect(@user.percent_rating).to eq(0)
    end
  end

end