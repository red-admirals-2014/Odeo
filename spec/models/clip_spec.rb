require 'spec_helper'

describe Clip do
   it { should belong_to(:user) }
   it { should have_many(:votes) }

   it "should not add https:// if it already exists in the clip_link" do
    clip = Clip.create(user_id: 1, clip_link: "https://test.org")
    expect(clip.clip_link).to eq("https://test.org")
   end

   it "should add https:// if it does not exist in the clip_link" do
    clip = Clip.create(user_id: 1, clip_link: "//test.org")
    expect(clip.clip_link).to eq("https://test.org")
   end
  
end