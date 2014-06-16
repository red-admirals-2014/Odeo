class Clip < ActiveRecord::Base
  belongs_to  :user
  has_many    :votes

  before_save :add_https

  def add_https
  	if self.clip_link.match("https://")
  	else
  		self.clip_link = "https:" + self.clip_link
  	end
  end

end