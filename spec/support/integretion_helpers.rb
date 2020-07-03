module IntegretionHelpers
  def is_logged_in?
    !session[:user_id].nil?
  end

  def log_in_as(user)
    visit login_path
    fill_in "Email", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン" 
  end

  def sign_in_as(user)
    post login_path, params: {session: {email: user.email,
                                        password: user.password}}
  end
end