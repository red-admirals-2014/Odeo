require 'spec_helper'

describe ClipsController do
  render_views

  context "index" do
    it  "a logged out user should be asked to sign in" do
      get :index
      expect(response.body).to have_content "Sign in with Facebook"
    end

    it "a logged in user should see their name" do
      # How do you stub a logged in user? Need to use stubbing with sessions. Will check in with Shadi/Anne on Monday. Also, render_views??
      # controller.stub(:current_user, {name: 'Tommy Carpenito'})
      # get :index
      # expect(response.body).to have_content "Welcome"
    end
  end

end
