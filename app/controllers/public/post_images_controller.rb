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
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def post_image_params
    params.require(:post_image).permit(:title, :body, :image)
  end

end
