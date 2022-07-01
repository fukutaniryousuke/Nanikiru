class Admin::PostImagesController < ApplicationController
  
  def index
    @post_images = PostImage.all.order(created_at: :desc)
  end
  
  def show
    @post_image = PostImage.find(params[:id])
  end
  
  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_back(fallback_location: root_path)
    flash[:notice] = "投稿を削除しました"
  end
end
