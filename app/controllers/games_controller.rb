class GamesController < ApplicationController
  def index
  end

  def create
    if params[:file].blank? || params[:file].content_type != "text/plain"
      redirect_to root_path, alert: "File missing or wrong format"
      return
    end

    matrix_reader = MatrixFileReader.new(params[:file].read)
    generation = @current_user.games.new({ generations_attributes: [{
      counter: matrix_reader.generation_number,
      columns: matrix_reader.columns,
      rows: matrix_reader.rows,
      matrix: matrix_reader.data
    }] })

    if generation.save
      # redirect user to game page
    else
      redirect_to root_path, alert: generation.errors.full_messages
    end
  end
end
