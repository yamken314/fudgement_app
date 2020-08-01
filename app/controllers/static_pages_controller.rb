class StaticPagesController < ApplicationController
  def home
    @microposts = Micropost.all.includes(:user, images_attachments: :blob).sorted
  end

  def help
  end

  def about
  end
end
