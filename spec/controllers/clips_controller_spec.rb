require 'spec_helper'

describe ClipsController do

  describe "index" do
  render_views
    it  "renders the login page for a new user" do
      get :index
      expect(response.body).to have_content "Oudio Oudio Log in with Facebook"
    end
    it "renders the homepage for a user already logged in" do
      user = User.create
      session[:user_id] = 1
      get :index
      expect(response.body).to have_content "Oudio Oudio Upload or record from your phone! Or Record yourself from the browser! Cancel"
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "saves new clip to the database" do
        # pending
        # new_user = User.create
        # session[:user_id] = new_user.id
        # expect{
        #   post :create, new_user
        # }.to change(Clip, :count).by(1)
      end
      it "redirects to root_path" do
        pending
        # new_user = FactoryGirl.create(:user)
        # session[:user_id] = new_user.id
        # post :create, FactoryGirl.attributes_for(:clip)
        # expect(response).to redirect_to root_path
      end
    end

    context "with invalid attributes" do
      it "does not save the new clip to the database" do
        pending "adding a validation to Clip model for clip_link presence gives an expectation to have views to render for no apparent reason"
      end
    end
  end
end
