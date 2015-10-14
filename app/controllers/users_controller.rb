class UsersController < ApplicationController
  expose(:user)
  expose(:users)
  expose(:announcements) { user.announcements }
  expose(:participants) { user.participants }
  
  def index
  end
  
  def show
  end
  
  def user_json
    render json: user
  end
  
  def user_announcements
    render json: announcements
  end
  
  def user_participants
    participations = participants.map { |x| x.announcement }
    render json: participations
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email, :name)
  end
end
