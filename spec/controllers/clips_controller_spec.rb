require 'spec_helper'

describe ClipsController do

  describe "index" do
  render_views
    it  "renders the login page for a new user" do
      get :index
      expect(response.body).to have_content "Odeo Odeo Log in with Facebook"
    end
    it "renders the homepage for a user already logged in" do
      user = User.create
      session[:user_id] = 1
      get :index
      expect(response.body).to have_content "Odeo Odeo logout Upload or Record Record Stop You are out of clips! Come back later for new clips!"
    end
  end

  describe "#create" do
      it "redirects to root_path upon successfull save" do
        @user = User.create
        session[:user_id] = @user.id
        post :create, {url: "tommy.com"}
        expect(response).to be_redirect
      end
      it "puts this failed when not succesfull" do
        # This is a useless test because no matter what, the response is a redirect.
        @user = User.create
        session[:user_id] = @user.id
        post :create
        expect(response).to be_redirect
      end
    end

end
