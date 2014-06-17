require 'spec_helper'

describe SessionsController do

  describe "#create" do
    it "redirects to the root URL upon creating a session" do
      fake_user = User.create
      User.stub(:from_omniauth).and_return( fake_user )
       # allow(user).to receive(:user) {"tommy"}
       # allow(session).to receive(session[:user_id]) {1}
      post :create, { provider: 'raorao'}
      expect(response).to be_redirect
    end
  end
end
