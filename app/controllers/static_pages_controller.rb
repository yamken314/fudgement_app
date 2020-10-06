class StaticPagesController < ApplicationController
  def home
    @microposts = Micropost.all.eager_load(user: {avatar_attachment: :blob}).with_attached_image.sorted_desc.page(params[:page])
    @colors = ['post_details_1','post_details_2', 'post_details_3', 'post_details_4']
  end

  def help
  end

  def about
  end
end
