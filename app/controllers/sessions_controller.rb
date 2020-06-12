class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
    else
    flash.now[:danger] = 'メール/パスワードの組み合わせが無効です'
    render 'new'
    end
  end
end
