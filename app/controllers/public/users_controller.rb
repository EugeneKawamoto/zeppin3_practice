class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :screen_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.page(params[:page]).reverse_order.per(5)
    @bookmarks = Bookmark.where(user_id: @user.id).all.page(params[:page]).reverse_order.per(5)
  end

  def edit
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to root_path
    elsif current_user.id = !@user.id
      redirect_to public_user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to public_users_my_page_path(current_user), notice: 'ユーザ情報の更新が完了しました。'
    else
      render action: :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def screen_user
    unless params[:id].to_i == current_user.id
      redirect_to public_users_my_page_path(current_user)
    end
  end
end
