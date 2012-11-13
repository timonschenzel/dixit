class Tag < ActiveRecord::Base
  attr_accessible :game_id, :tag, :created_at, :updated_at

  belongs_to :game

  #validates :tag, presence: true
end
