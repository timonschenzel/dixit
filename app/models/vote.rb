class Vote < ActiveRecord::Base
  attr_accessible :user_id, :picture_id, :created_at, :updated_at

  belongs_to :user
  belongs_to :picture
end
