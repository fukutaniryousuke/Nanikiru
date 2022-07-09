class Admin::PostCommentsController < ApplicationController
  before_action :set_post_image

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
    flash[:notice] = "コメントを削除しました"
  end

  def set_post_image
    @post_image = PostImage.find(params[:post_image_id])
  end
end
