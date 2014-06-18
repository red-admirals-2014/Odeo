class Clip < ActiveRecord::Base
  belongs_to  :user
  has_many    :votes
  validates   :clip_link, presence: true

  before_save :add_https

  def self.get_next_clip(user, song_url)
    if song_url == "https://s3-us-west-1.amazonaws.com/akfoster/users/Music/01-03-+Dirt+and+Roses.mp3"
      potential_next_songs = self.where(created_at: (Time.now - 1.day)..Time.now + 1.day)
      voted_on = potential_next_songs.includes(:votes).where('votes.user_id = ?', user.id).references(:votes)
      clip_link = (potential_next_songs - voted_on).sample.clip_link
    else
      potential_next_songs = self.where(created_at: (Time.now - 1.day)..Time.now + 1.day)
      voted_on = potential_next_songs.includes(:votes).where('votes.user_id = ?', user.id).references(:votes)
      clip_link_options = (potential_next_songs - voted_on)
      if clip_link_options.length > 0
        clip_link_options.sample.clip_link
      else
        "end"
      end
  end

  def add_https
    if self.clip_link.match("https://")
    else
      self.clip_link = "https:" + self.clip_link
    end
  end
end