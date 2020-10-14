class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    auth = request.env['omniauth.auth']
    if auth.present?
      @user = User.find_or_create_from_auth(request.env['omniauth.auth'])
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー認証が完了しました。"
      redirect_to root_path
    elsif @user && @user.authenticate(params[:session][:password])
        log_in @user
        params[:session][:remember_me] == '1'? remember(@user) : forget(@user)
        redirect_to @user
    else
      flash.now[:danger] = 'メール/パスワードの組み合わせが無効です'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end

  def new_guest
    user = User.guest
    log_in user
    flash[:succces] = "ゲストログインしました。"
    redirect_to root_path
  end
end
