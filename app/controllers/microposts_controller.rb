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
    @micropost = Micropost.find(params[:id])
    @colors = ['post_details_show_1', 'post_details_show_2', 'post_details_show_3', 'post_details_show_4']
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, images: [], choices_attributes: [:name])
    end
end
