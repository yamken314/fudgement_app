class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :currect_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @microposts = current_user.microposts.all.includes(:choices).with_attached_images.sorted_desc
    @color = [ "background: linear-gradient(#FA709A 30%, #FBAB7E 60%, #F7CE68 100%);
                box-shadow: 0 6px #7295acf5;
                top: 0;
                transition: .2s box-shadow,.2s top,.4s;",
                "background-color: #ffcfdf;
                background-image: linear-gradient(315deg, #ffcfdf 0%, #b0f3f1 74%);
                box-shadow: 0 6px #526fa5;
                top: 0;
                transition: .2s box-shadow,.2s top,.4s;",
                "background-color: #09c7fb;
                background-image: linear-gradient(315deg, #09c7fb 0%, #93fb9d 74%);
                box-shadow: 0 6px #526fa5;
                top: 0;
                transition: .2s box-shadow,.2s top,.4s;",
                "background-color: #f876de;
                background-image: linear-gradient(315deg, #f876de 0%, #b9d1eb 74%);
                box-shadow: 0 6px #526fa5;
                top: 0;
                transition: .2s box-shadow,.2s top,.4s;"]
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
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
    if @user.update_attributes(user_params)
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

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
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
