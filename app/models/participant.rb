class Participant < ActiveRecord::Base
  attr_accessible :user_id, :round_id, :score, :is_storyteller, :created_at, :updated_at

  belongs_to :round
  belongs_to :user
  has_many :pictures
end
