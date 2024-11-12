class GamesController < ApplicationController
  def index
    @past_simulations = @current_user.games.ordered.includes(:generations)
                        .left_joins(:generations)
                        .select("games.*, COUNT(generations.id) AS generations_count")
                        .group("games.id")
                        .limit(5)

    @game = Game.new({ generations_attributes: [{}] })
  end

  def create
    game = @current_user.games.new(game_params)
    if game.save
      redirect_to game_generation_path(game, game.generations.first)
    else
      handle_failed_save(game, "tab-2", "input_form")
    end
  end

  def upload
    unless valid_file_type?
      redirect_to root_path, alert: "Only .txt files are allowed"
      return
    end

    game = @current_user.games.new(attributes_from_file)
    if game.save
      redirect_to game_generation_path(game, game.generations.first)
    else
      handle_failed_save(game, "tab-1", "upload_form")
    end
  end

  private

  def valid_file_type?
    params[:file].content_type == "text/plain"
  end

  def attributes_from_file
    matrix_reader = MatrixFileReader.new(params[:file].read)
    {
      generations_attributes: [{
        counter: matrix_reader.generation_number,
        columns: matrix_reader.columns,
        rows: matrix_reader.rows,
        matrix: matrix_reader.data
      }]
    }
  end

  def game_params
    params.require(:game).permit(generations_attributes: [:counter, :columns, :rows, :matrix])
  end

  def handle_failed_save(game, tab, partial)
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace(tab, partial: partial, locals: { game:, from_view: false }) }
      format.html { redirect_to root_path, alert: game.errors.full_messages }
    end
  end
end
