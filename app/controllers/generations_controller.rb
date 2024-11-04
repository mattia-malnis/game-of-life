class GenerationsController < ApplicationController
  before_action :set_generation
  def show
  end

  def next_generation
    @generation = @generation.find_or_create_next_generation
    render :show
  end

  private

  def set_generation
    @generation = Generation
                  .joins(game: :user_session)
                  .where(user_sessions: { id: @current_user.id })
                  .find(params[:id])
  end
end
