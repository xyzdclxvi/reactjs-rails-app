class UsersController < ApplicationController
  expose(:user)
  expose(:users)
  expose(:announcements) { user.announcements }
  expose(:participants) { user.participants }
  
  def index
  end
  
  def show
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email)
  end
end
