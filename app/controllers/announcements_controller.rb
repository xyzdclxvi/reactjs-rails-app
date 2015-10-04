class AnnouncementsController < ApplicationController
  expose(:announcements)
  expose(:announcement)
  expose(:author) { announcement.user }
  expose(:participants) { announcement.participants }
  
  def get_participants
    users = participants.map { |x| x.user }
    render json: users
  end
  
  def get_author
    render json: author
  end
  
  def index
    @announcements_data = announcements.map do |announcement|
      announcement.to_json[0...-1] +
        ",\"author_name\":\"#{announcement.user.name}\"" +
        ",\"participants_count\":\"#{announcement.participants.count}\"}"
    end
    @announcements_data = "{\"data\":{\"announcements\":[#{@announcements_data.join(",")}],\"current_user\":#{current_user ? current_user.to_json : "null"}}}"  
  end

end
