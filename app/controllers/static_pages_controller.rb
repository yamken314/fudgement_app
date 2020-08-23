class StaticPagesController < ApplicationController
  def home
    @microposts = Micropost.all.includes(:user, :choices).with_attached_images.sorted_desc
    @colors = ['post_details_1','post_details_2']
  end

  def help
  end

  def about
  end
end
