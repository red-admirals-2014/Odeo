require 'spec_helper'

describe User do 


  context "associations" do
    it { should have_many(:clips) }
    it { should have_many(:votes) }
  end

  context "validations" do
    it { should validate_presence_of :provider }
    it { should validate_presence_of :uid }
    it { should validate_presence_of :name }
    it { should validate_presence_of :oauth_token }
    it { should validate_presence_of :oauth_expires_at }
  end

  context "#from_omniauth" do
    before (:each) do
      info = double("info")
      info.stub(:name) { "name" }

      credentials = double("credentials")
      credentials.stub(:token)      { "token" }
      credentials.stub(:expires_at) { 1403135425 }

      @auth = double("auth")
      @auth.stub(:slice)       { { provider: "facebook", uid: "uid" } }
      @auth.stub(:provider)    { "facebook"}
      @auth.stub(:uid)         { "uid" }
      @auth.stub(:info)        { info }
      @auth.stub(:credentials) { credentials }
      
    end

    it "should create a user given valid facebook information" do
      User.from_omniauth(@auth)
      expect(User.last).to_not be_nil
    end

    it "should return an existing user given valid facebook information" do
      user = User.from_omniauth(@auth)
      user2 = User.from_omniauth(@auth)
      expect(User.count).to be(1)
    end

  end

  context "#percent_rating" do

    before (:each) do
      @user = User.create( provider: "facebook", uid: "uaf", name: "user1", oauth_token: "kafjkje", oauth_expires_at: Time.now )
      @user2 = User.create( provider: "facebook", uid: "lkj", name: "user2", oauth_token: "alfkj", oauth_expires_at: Time.now )
    end

    it "should return a percent rating of liked clips if over 0" do
      clip1 = Clip.create( user_id: @user.id, clip_link: "https://test.com" )
      clip2 = Clip.create( user_id: @user.id, clip_link: "https://test.org" ) 
      vote1 = Vote.create( user_id: @user2.id, clip_id: clip1.id, like: true )
      vote2 = Vote.create( user_id: @user2.id, clip_id: clip2.id, like: false )
      expect(@user.percent_rating).to eq(50)
    end

    it "should return 0 if there are no liked clips" do
      expect(@user.percent_rating).to eq(0)
    end
  end

end