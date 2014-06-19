require 'spec_helper'

def stub_current_user (user)
  ApplicationController.any_instance.stub(:current_user) { user }
end

describe ClipsController do

  describe "index" do
  render_views
    it  "renders the login page for a new user" do
      get :index
      expect(response.body).to have_content "Odeo Odeo Log in with Facebook"
    end
  end

  describe "#create" do

    before (:each) do
      @user = User.create( provider: "facebook", uid: "uaf", name: "user1", oauth_token: "kafjkje", oauth_expires_at: Time.now )
    end
      
    it "redirects to root_path upon successful save" do
        session[:user_id] = @user.id
        post :create, {url: "tommy.com"}
        expect(response).to be_redirect
    end
      
    it "puts this failed when not succesful" do
        # This is a useless test because no matter what, the response is a redirect.
        session[:user_id] = @user.id
        post :create
        expect(response).to be_redirect
    end
  end

  describe "#next" do

    before (:each) do
      @user = User.create( provider: "facebook", uid: "uaf", name: "user1", oauth_token: "kafjkje", oauth_expires_at: Time.now )
    end

    it "renders the next link when the link is not the end" do
      stub_current_user(@user)
      new_clip = Clip.create(user_id: 1, clip_link: "https://test.example.org")
      get :next, :url => "https://example.test.com"
      expect(response.body).to include(new_clip.clip_link)
    end

    it "renders end when there are no more songs" do
      stub_current_user(@user)
      get :next, :url => "https://example.test.com"
      expect(response.body).to include("end")
    end
  end

  describe "#server" do
    before (:each) do
      @user = User.create( provider: "facebook", uid: "uaf", name: "user1", oauth_token: "kafjkje", oauth_expires_at: Time.now )
    end
    it "should return the rating for use in the DOM" do
      stub_current_user(@user)
      get :server
      expect(response.body).to include(@user.percent_rating.to_s)
    end
  end

end
