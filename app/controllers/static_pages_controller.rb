class StaticPagesController < ApplicationController
  def home
    @microposts = Micropost.all.includes(:user, :choices).with_attached_images.sorted_desc
  end

  def help
  end

  def about
  end
end
