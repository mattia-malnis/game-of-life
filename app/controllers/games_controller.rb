class GamesController < ApplicationController
  def index
  end

  def create
    if params[:file].blank? || params[:file].content_type != "text/plain"
      redirect_to root_path, alert: "File missing or wrong format"
      return
    end

    matrix_reader = MatrixFileReader.new(params[:file].read)
    game = @current_user.games.new({ generations_attributes: [{
      counter: matrix_reader.generation_number,
      columns: matrix_reader.columns,
      rows: matrix_reader.rows,
      matrix: matrix_reader.data
    }] })

    if game.save
      redirect_to game_generation_path(game, game.generations.first )
    else
      redirect_to root_path, alert: game.errors.full_messages
    end
  end
end
