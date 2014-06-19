class User < ActiveRecord::Base
  has_many :clips
  has_many :votes
  validates :provider, :uid, :name, :oauth_token, :oauth_expires_at, presence: true

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def percent_rating
    num_clips_with_votes = (Clip.joins(:votes).where('clips.user_id = ?', self.id).count).to_f
    num_clips_liked = Clip.joins(:votes).where('clips.user_id = ? AND votes.like = true', self.id).count
    if num_clips_liked != 0
      rating = (num_clips_liked / num_clips_with_votes) * 100
      rating.to_i
    else
      0
    end
  end

end