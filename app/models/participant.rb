class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :announcement
  
  validates :user, presence: true
  validates :announcement, presence: true
  
  #status has no functionality yet
  #validates :status, presence: true

end
