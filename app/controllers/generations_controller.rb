class GenerationsController < ApplicationController
  before_action :set_game
  before_action :set_generation
  def show
  end

  def next_generation
    @generation = @generation.find_or_create_next_generation
    render :show
  end

  private

  def set_game
    @game = @current_user.games.find(params[:game_id])
  end

  def set_generation
    @generation = @game.generations.find(params[:id])
  end
end
