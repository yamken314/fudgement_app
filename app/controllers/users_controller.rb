class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :currect_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :set_users, only: [:following, :followers]
  before_action :set_delete, only: [:delete_profile_image, :delete_avatar]

  def index
    @users = User.includes(avatar_attachment: :blob).paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.all.with_attached_image.sorted_desc.page(params[:page])
    @colors = %w[post_details_1 post_details_2 post_details_3 post_details_4]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save(context: :password)
      log_in @user
      flash[:succces] = "新規登録完了しました"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:succces] = "編集しました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:succces] = "削除されました"
    redirect_to users_url
  end

  def delete_profile_image
  end

  def delete_avatar
  end

  def following
  end

  def followers
  end

  private

  def set_users
    @user = User.find(params[:id])
    users = action_name == 'following' ? @user.following : @user.followers
    @title = action_name == 'following' ? "フォロー中" : "フォロワー"
    @users = users.paginate(page: params[:page])
    render 'show_follow'
  end

  def set_delete
    @user = User.find(params[:id])
    action_name == 'delete_profile_image' ? @user.profile_image.purge : @user.avatar.purge
    redirect_to @user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduction, :profile_image, :avatar)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "ログインして下さい"
      redirect_to login_url
    end
  end

  def currect_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
