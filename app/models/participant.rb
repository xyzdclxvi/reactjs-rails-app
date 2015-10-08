class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :announcement
  
  validates :user, presence: true
  validates :announcement, presence: true
  validates_uniqueness_of :user_id, :scope => :announcement_id
  
  #status has no functionality yet
  #validates :status, presence: true

end
