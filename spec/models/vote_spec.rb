require 'spec_helper'

describe Vote do
  it { should belong_to(:user) }
  it { should belong_to(:clip) }
  it { should validate_uniqueness_of(:user_id).scoped_to(:clip_id) }
end