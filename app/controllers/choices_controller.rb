class ChoicesController < ApplicationController
  before_action :set_choice, only:[:edit, :update, :destroy]
  def destroy
    @choice.destroy
    flash[:success] = "ボタンを削除しました"
    redirect_to micropost_path(@choice.micropost.id)
  end

  def edit
  end

  def update
    if @choice.update(choice_params)
      flash[:success] = "ボタンを更新しました"
      redirect_to micropost_path(@choice.micropost.id)
    end
  end

  private
  
    def choice_params
      params.require(:choice).permit(:id, :name, :user_id)
    end

    def set_choice
      @choice = Choice.find(params[:id])
    end
end