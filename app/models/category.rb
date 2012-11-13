class Category < ActiveRecord::Base
  attr_accessible :name, :description, :created_at, :updated_at

  has_many :games
end
