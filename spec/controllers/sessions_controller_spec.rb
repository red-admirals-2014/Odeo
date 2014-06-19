require 'spec_helper'

describe SessionsController do
    before (:each) do
      @user = User.create( provider: "facebook", uid: "uaf", name: "user1", oauth_token: "kafjkje", oauth_expires_at: Time.now )
    end

  describe "#create" do
    it "sets a session id upon user creation" do
      post :create, {provider: 'no_provider'}
      expect(session[:user_id]).to be(1)
    end
    it "redirects to the root URL upon creating a session" do
      post :create, { provider: 'no_provider'}
      expect(response).to be_redirect
    end
  end

  describe "#destroy" do
    it "sets a session to nil upon logout" do
      post :destroy
      expect(session[:user_id]).to be(nil)
    end
    it "redirects to the root_url upon destruction" do
      post :destroy
      expect(response).to be_redirect
    end
  end
end
