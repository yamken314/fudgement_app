class StaticPagesController < ApplicationController
  def home
    @users = User.includes(microposts: [images_attachments: :blob])
  end

  def help
  end

  def about
  end
end