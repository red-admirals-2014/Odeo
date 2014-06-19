require 'spec_helper'

describe SessionsController do
    before (:each) do
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
      fake_user = User.create
      User.stub(:from_omniauth).and_return( fake_user )
    end

  describe "#create" do
    it "sets a session variable to the OmniAuth auth hash" do
      request.env["omniauth.auth"]['uid'].should == '1234'
    end
    it "should successfully create a session" do
      session[:user_id].should be_nil
      post :create, {provider: :facebook}
      session[:user_id].should_not be_nil
    end
    it "should redirect the user to the root url" do
      post :create, { provider: :facebook}
      response.should redirect_to root_path
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
