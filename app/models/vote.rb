class Vote < ActiveRecord::Base
	belongs_to	:user
	belongs_to	:clip
	validates_uniqueness_of	:user_id, scope: :clip_id
end


