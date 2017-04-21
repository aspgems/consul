class Admin::ParticipantsController < Admin::BaseController

  def index
    @users = User.all.order('created_at desc')

    respond_to do |format|
      format.csv { send_data(@users.to_csv, filename: "#{t('.filename')}-#{Date.today}.csv") }
    end
  end

end
