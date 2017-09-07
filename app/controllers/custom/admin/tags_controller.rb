class Admin::TagsController < Admin::BaseController
  before_action :find_tag, only: [:update, :destroy]

  respond_to :html, :js

  def index
    @tags = ActsAsTaggableOn::Tag.category.page(params[:page])
    @tag  = ActsAsTaggableOn::Tag.category.new
  end

  def create
    ActsAsTaggableOn::Tag.category.create(tag_params)
    redirect_to admin_tags_path
  end

  def update
    @tag.update(tag_params)
    redirect_to admin_tags_path
  end

  def destroy
    @tag.destroy
    redirect_to admin_tags_path
  end

  private

    def tag_params
      params[:tag][:kind] = params[:tag][:kind] == "1" ? "category" : nil
      params.require(:tag).permit(:name, :kind)
    end

    def find_tag
      @tag = ActsAsTaggableOn::Tag.category.find(params[:id])
    end

end
