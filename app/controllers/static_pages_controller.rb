class StaticPagesController < ApplicationController
  def home
    @users = User.includes(:microposts)
  end

  def help
  end

  def about
  end
end
