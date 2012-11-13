class Game < ActiveRecord::Base
  attr_accessible :category_id, :name, :description, :created_at, :updated_at, :rounds_attributes, :tags_attributes

  has_many :rounds
  has_many :pictures, through: :rounds
  has_many :tags
  belongs_to :category
  accepts_nested_attributes_for :rounds, :tags
end
