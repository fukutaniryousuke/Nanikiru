class Public::PostImagesController < ApplicationController
  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.customer_id = current_customer.id
    if @post_image.save
      redirect_to post_image_path(@post_image)
      flash[:notice] = "投稿しました"
    else
      render "new"
    end
  end

  def index
    @post_images = PostImage.all.order(created_at: :desc)
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post_image = PostImage.find(params[:id])
  end

  def update
    @post_image = PostImage.find(params[:id])
    if @post_image.update(post_image_params)
      redirect_to post_image_path(@post_image)
      flash[:notice] = "変更を完了しました"
    else
      render "edit"
    end
  end

  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.delete
    redirect_to customers_path(current_customer)
    flash[:notice] = "投稿を削除しました"
  end

  private

  def post_image_params
    params.require(:post_image).permit(:title, :body, :image)
  end

end
