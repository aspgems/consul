require_dependency Rails.root.join('app', 'controllers', 'admin', 'verifications_controller').to_s

class Admin::VerificationsController < Admin::BaseController

  def index
    @users = User.unverified.page(params[:page]).for_render
  end

  def search
    @users = User.unverified.search_unverified(params[:term]).page(params[:page]).for_render
    render :index
  end

  def create
    @user = User.unverified.find(params[:user_id])
    if @user
      @user.update(verified_at: Time.now)
      Mailer.account_verification(@user, @user.email).deliver_later
    end
    redirect_to search_admin_verifications_path(request.query_parameters.dup.extract!(:term, :page)),
                notice: t("admin.settings.flash.updated")
  end

end
