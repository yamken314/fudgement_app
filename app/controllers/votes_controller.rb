class VotesController < ApplicationController
  def create
    vote = current_user.votes.build(choice_id: params[:choice_id])
    vote.save
    redirect_to root_path
  end

  def destroy
    vote = Vote.find_by(choice_id: params[:choice_id], user_id: current_user.id)
    vote.destroy
    redirect_to root_path
  end
end
