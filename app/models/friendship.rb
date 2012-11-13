class Friendship < ActiveRecord::Base
  attr_accessible :user_id, :friend_id, :created_at, :updated_at

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  after_create :create_inverse_relation, unless: Proc.new {
    Friendship.where(user_id: self.friend_id, friend_id: self.user_id).exists?
  }

  private
    def create_inverse_relation
      self.class.create!(user_id: self.friend_id, friend_id: self.user_id)
      puts "callback: #{self}"
    end
end
