class AnnouncementsController < ApplicationController
  expose(:announcements)
  expose(:announcement)
  expose(:author) { announcement.user }
  expose(:participants) { announcement.participants }
  
  def get_participants
    users = participants.map { |x| x.user.status = x.status; x.user }
    render json: users, methods: [:status]
  end
  
  def get_author
    render json: author
  end
  
  def add_participant
    @participant = Participant.new(announcement: announcement, user: current_user)
    if current_user && @participant.save
      render json: @participant
    else
      render json: @participant.errors, status: :unprocessable_entity
    end
  end
  
  def remove_participant
    @participant = announcement.participants.where(user: current_user)[0]
    if current_user && !@participant.nil?
      @participant.destroy
    end
    render json: nil
  end
  
  def accept_participant
    if current_user == author
      @participant = announcement.participants.where(user_id: params[:user_id])[0]
      if @participant
        @participant.status = 'accepted'
        @participant.save
      end
    end
    render json: nil
  end
  
  def reject_participant
    if current_user == author
      @participant = announcement.participants.where(user_id: params[:user_id])[0]
      if @participant
        @participant.status = 'rejected'
        @participant.save
      end
    end
    render json: nil
  end
  
  def index
    @announcements_data = announcements.map do |announcement|
      announcement.to_json[0...-1] +
        ",\"author_name\":\"#{announcement.user.name}\"" +
        ",\"author_image\":\"#{announcement.user.image}\"" +
        ",\"participants_count\":\"#{announcement.participants.count}\"}"
    end
    @announcements_data = "{\"data\":{\"announcements\":[#{@announcements_data.join(",")}],\"current_user\":#{current_user ? current_user.to_json : "null"}}}"  
  end
  
  private
  
  def announcement_params
    params.require(:announcement).permit(:title, :description)
  end

end
