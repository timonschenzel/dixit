class OauthUser < ActiveRecord::Base
  attr_accessible :provider, :uid, :created_at, :updated_at

  has_many :votes
  has_many :participants
  has_many :friendships

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      #user.name = auth["info"]["name"]
    end
  end
end
