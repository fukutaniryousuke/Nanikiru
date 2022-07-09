class Public::PostCommentsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_post_image
  def create
    post_image = PostImage.find(params[:post_image_id])
    comment = current_customer.post_comments.new(post_comment_params)
    comment.post_image_id = post_image.id
    if comment.save
      comment.post_image.create_notification_comment!(current_customer, comment.id)
    end
  end

  def destroy
    PostComment.find(params[:id]).destroy
  end

  def set_post_image
    @post_image = PostImage.find(params[:post_image_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
