class MicropostsController < ApplicationController
  before_action :logged_in_user, only:[:create,:destroy]
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "コメントを作成しました"
      redirect_to root_url
    else
      render 'microposts/new'
    end
  end

  def destroy
  end

  def new
    @micropost = current_user.microposts.build if logged_in?
    4.times { @micropost.choices.build }
  end

  def show
    @micropost = Micropost.with_attached_images.find(params[:id])
    @colors = ['post_details_show_1', 'post_details_show_2', 'post_details_show_3', 'post_details_show_4']
  end

  def edit
    @micropost = Micropost.with_attached_images.find(params[:id])
    @colors = ['post_details_show_1', 'post_details_show_2', 'post_details_show_3', 'post_details_show_4']
  end

  def update
    @micropost = Micropost.find(params[:id])
    if @micropost.update(micropost_params)
      flash[:success] = "更新しました"
      redirect_to micropost_path
    else
      render 'edit'
    end
    if image = params[:micropost][:image_ids]
      image.each do |image_id|
        @micropost.images.find(image_id).purge
      end
    end
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, images: [], choices_attributes: [:id,:name])
    end
end
