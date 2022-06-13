class Public::FavoritesController < ApplicationController
  def create
    post_image = PostImage.find(params[:post_image_id])
    favorite = current_customer.favorites.new(post_image_id: post_image.id)
    favorite.save
    redirect_back(fallback_location: root_path)
    post_image.create_notification_by(current_customer)
    #必要ないかも？
    # respond_to do |format|
    #   format.html {redirect_to request.referrer}
    #   format.js
    #   end
  end

  def destroy
    post_image = PostImage.find(params[:post_image_id])
    favorite = current_customer.favorites.find_by(post_image_id: post_image.id)
    favorite.destroy
    redirect_back(fallback_location: root_path)
  end

end
