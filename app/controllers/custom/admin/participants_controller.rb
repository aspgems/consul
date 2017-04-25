class Admin::ParticipantsController < Admin::BaseController

  def index
    users = User.sort_by_newest

    respond_to do |format|
      format.csv { send_data(users.to_csv, filename: "#{t('.filename')}-#{Time.zone.today}.csv") }
    end
  end

end
