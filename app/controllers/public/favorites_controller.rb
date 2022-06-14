class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_post_image
  def create
    post_image = PostImage.find(params[:post_image_id])
    favorite = current_customer.favorites.new(post_image_id: post_image.id)
    favorite.save
    # redirect_back(fallback_location: root_path)
    post_image.create_notification_by(current_customer)

  end

  def destroy
    post_image = PostImage.find(params[:post_image_id])
    favorite = current_customer.favorites.find_by(post_image_id: post_image.id)
    favorite.destroy
    # redirect_back(fallback_location: root_path)
  end

  def set_post_image
     @post_image = PostImage.find(params[:post_image_id])
  end

end
