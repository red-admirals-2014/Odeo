require 'spec_helper'

describe ClipsController do

  describe "index" do
  render_views
    it  "renders the login page for a new user" do
      get :index
      expect(response.body).to have_content "Odeo Odeo Log in with Facebook"
    end
  end

  describe "#create" do
      it "redirects to root_path upon successful save" do
        @user = User.create
        session[:user_id] = @user.id
        post :create, {url: "tommy.com"}
        expect(response).to be_redirect
      end
      it "puts this failed when not succesful" do
        # This is a useless test because no matter what, the response is a redirect.
        @user = User.create
        session[:user_id] = @user.id
        post :create
        expect(response).to be_redirect
      end
    end

    describe "#next" do
      it "renders the next clip link if there are available clips" do
      
      end

      it "renders end if there are no available clips" do
      end
    end

end
