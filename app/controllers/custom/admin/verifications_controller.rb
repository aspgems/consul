require_dependency Rails.root.join('app', 'controllers', 'admin', 'verifications_controller').to_s
# The controller name is correct?? Should be user_unverified_controller?.
class Admin::VerificationsController < Admin::BaseController

  def index
    @users = User.unverified.page(params[:page]).for_render
  end

  def search
    @users = User.unverified.search_unverified(params[:term]).page(params[:page]).for_render
    render :index
  end

  # Create and destroy methods should be here? Is the correct place?.
  def create
    @user = User.unverified.find(params[:user_id])
    if @user
      @user.update(verified_at: Time.current)
      Mailer.account_verification(@user, @user.email).deliver_later
    end
    redirect_to search_admin_verifications_path(request.query_parameters.slice(:term, :page)),
                notice: t('admin.settings.flash.updated')
  end

  def destroy
    @user = User.unverified.find(params[:id])
    @user.destroy_verification
    redirect_to search_admin_verifications_path(request.query_parameters.slice(:term, :page)),
                notice: t('admin.settings.flash.updated')
  end

end
