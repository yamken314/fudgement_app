class VotesController < ApplicationController
  before_action :logged_in_user, only:[:create, :destroy]
  
  def create
    vote = current_user.votes.build(choice_id: params[:choice_id])
    @choice = Choice.find(params[:choice_id])
    @micropost = Micropost.find(@choice.micropost.id)
    vote.save
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  def destroy
    vote = Vote.find_by(choice_id: params[:choice_id], user_id: current_user.id)
    @choice = Choice.find(params[:choice_id])
    @micropost = Micropost.find(@choice.micropost.id)
    vote.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end
end
