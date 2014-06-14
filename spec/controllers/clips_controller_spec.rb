require 'spec_helper'

describe ClipsController do

  # context "index" do
  #   it  "Links the user to a sign in link if they are not signed in" do
  #     visit root_path
  #     puts "************************"
  #     puts page.document
  #     expect(page).to have_content "Sign in with Facebook"
  #   end
  # end
  context "index" do
    it  "" do
      get :index
      puts "********** RESPONSE ************"
      puts current_user.inspect
      puts response.body
      expect(response).to have_content "Sign in with Facebook"
    end
  end

end
