require 'spec_helper'

describe User do 

  before (:each) do
    fake_user = User.create
    User.stub(:from_omniauth).and_return( fake_user)
  end

  context "associations" do
    it { should have_many(:clips) }
    it { should have_many(:votes) }
  end

  it "should create a user when a new user logs in from facebook" do
    facebook_auth = {"provider" => "facebook", "uid" => "asfd", "info" => { "email" => "test.example.com", "name" => "tester"}}
    user = User.from_omniauth(facebook_auth)
    expect(User.last).to eq(user)
  end

  it "should return an existing user when an existing user logs in from facebook" do
    facebook_auth = {"provider" => "facebook", "uid" => "asfd", "info" => { "email" => "test.example.com", "name" => "tester"}}
    user = User.from_omniauth(facebook_auth)
    user2 = User.from_omniauth(facebook_auth)
    expect(User.find(user.id)).to eq(user2)
  end

end