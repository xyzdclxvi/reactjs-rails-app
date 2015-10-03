class Announcement < ActiveRecord::Base
  belongs_to :user
  has_many :participants
  
  validates :title, presence: true
  validates :user, presence: true
  
end
