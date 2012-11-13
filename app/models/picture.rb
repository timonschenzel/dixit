class Picture < ActiveRecord::Base
  attr_accessible :user_id, :round_id, :votes, :is_start_picture, :is_final_picture, :flickr_id, :created_at, :updated_at

  belongs_to :participant
  belongs_to :round
  has_many :votes
end
