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
    
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content,:vote_1,:vote_2,:vote_3,:vote_4,:picture)
    end
end
