require 'spec_helper'

describe ClipsController do

  context "index" do
    it  "renders the clips view" do
      root
      expect(response).to_not be(success)
    end
  end

end
