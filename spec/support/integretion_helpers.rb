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

  def post_content
    click_link "Judgement"
    fill_in "コメントを記入して下さい", with: "test"
    fill_in "Choiceボタン名を記入して下さい", with: "choice"
  end
end