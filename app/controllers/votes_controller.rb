class VotesController < ApplicationController
  def create
    vote = current_user.votes.build(choice_id: params[:choice_id])
    @choice = Choice.find(params[:choice_id])
    vote.save
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  def destroy
    vote = Vote.find_by(choice_id: params[:choice_id], user_id: current_user.id)
    @choice = Choice.find(params[:choice_id])
    vote.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end
end
