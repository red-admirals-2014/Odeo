require 'spec_helper'

describe SessionsController do

  describe "#create" do

    before (:each) do
      fake_user = User.create
      User.stub(:from_omniauth).and_return( fake_user )
    end

    it "sets a session id upon user creation" do
      post :create, {provider: 'no_provider'}
      expect(session[:user_id]).to be(1)
    end

    it "redirects to the root URL upon creating a session" do
      post :create, { provider: 'no_provider'}
      expect(response).to be_redirect
    end

  end
end
