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
    @user.update(verified_at: Time.now) if @user
    redirect_to search_admin_verifications_path(request.query_parameters.dup.extract!(:term, :page)),
                notice: t("admin.settings.flash.updated")
  end

  def destroy
    @user = User.unverified.find(params[:user_id])
    @user.update(document_number: nil)
    @user.update(residence_verified_at: nil) if @user
    redirect_to search_admin_verifications_path(request.query_parameters.dup.extract!(:term, :page)),
                notice: t("admin.settings.flash.updated")
  end

end
