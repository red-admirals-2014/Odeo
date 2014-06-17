require 'spec_helper'

describe Clip do
   it { should belong_to(:user) }
   it { should have_many(:votes) }

   
  
end