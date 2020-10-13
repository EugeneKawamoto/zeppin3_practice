class Public::ReviewsController < ApplicationController

  def new
    @review = Review.new
    @review.review_images.build
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      flash[:notice] = "投稿は正常に完了しました."
      redirect_to public_root_path
    else
      render action: :new
    end
  end

  def index
    @reviews = Review.all
  end

  def show
    
  end


  def edit
    
  end

  def update

  end

  def destroy
    
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :restaurant_id, :menu_id, :comment, :rate, review_images_images: [])
  end

end
