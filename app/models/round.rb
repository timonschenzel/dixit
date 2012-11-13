class Round < ActiveRecord::Base
  attr_accessible :game_id, :story_fragment, :created_at, :updated_at, :pictures_attributes

  has_many :participants
  has_many :pictures
  belongs_to :game

  accepts_nested_attributes_for :pictures
end
