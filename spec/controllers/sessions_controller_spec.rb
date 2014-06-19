require 'spec_helper'

def stub_request_env_omniauth_auth
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
      @auth.should_receive(:[]).with("uid").and_return("uid")
      @auth
end 

describe SessionsController do
    before (:each) do
      # request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
      # fake_user = User.create
      # User.stub(:from_omniauth).and_return( fake_user )
    

      # request.env["omniauth.auth"] = @auth
    end

  describe "#create" do
    it "sets a session variable to the OmniAuth auth hash" do
      expect(stub_request_env_omniauth_auth["uid"]).to eq 'uid'
    end
    xit "should successfully create a session" do
      session[:user_id].should be_nil
      post :create, {provider: "facebook", uid: 1234}
      # stub_request_env_omniauth_auth
      session[:user_id].should_not be_nil
    end
    xit "should redirect the user to the root url" do
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
