class ChoicesController < ApplicationController
  def destroy
    choice = Choice.find(params[:id])
    choice.destroy
    redirect_back(fallback_location: root_path)
  end
end