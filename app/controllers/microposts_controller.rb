class MicropostsController < ApplicationController
  before_action :logged_in_user, only:[:create,:destroy, :edit, :show ]
  before_action :set_micropost, only:[:show, :edit, :update]
  before_action :set_colors, only:[:show, :edit, :update]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    respond_to do |format|
      if @micropost.save
        format.html { redirect_to root_url }
        flash[:success] = "コメントを作成しました"
      else
        format.html { render :_new_post }
      end
    end
  end

  def new
    @micropost = current_user.microposts.build if logged_in?
    @micropost.choices.build
  end

  def show
  end

  def edit
  end

  def update
    if @micropost.update(micropost_params) then
      flash[:success] = "更新しました"
      redirect_to micropost_path  
    elsif
      @micropost.user == current_user then
      render 'edit'
    else
      render 'show'
    end
    if image = params[:micropost][:image_ids]
      image.each do |image_id|
        @micropost.images.find(image_id).purge
      end
    end
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, images: [], choices_attributes: [:id,:name, :user_id, :_destroy])
    end

    def set_micropost
      @micropost = Micropost.with_attached_images.find(params[:id])
      @choice = @micropost.choices.eager_load(:user)
    end

    def set_colors
      @colors = ['post_details_show_1', 'post_details_show_2', 'post_details_show_3', 'post_details_show_4']
    end
end
