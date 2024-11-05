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
    if file_upload?
      handle_file_upload
    else
      game = @current_user.games.new(game_params)
      handle_game_creation(game)
    end
  end

  private

  def handle_file_upload
    unless valid_file_type?
      redirect_to root_path, alert: "Only .txt files are allowed"
      return
    end

    game = @current_user.games.new(attributes_from_file)
    handle_game_creation(game)
  end

  def handle_game_creation(game)
    if game.save
      redirect_to game_generation_path(game, game.generations.first)
    else
      respond_to do |format|
        if file_upload?
          format.turbo_stream { render turbo_stream: turbo_stream.replace("tab-1", partial: "upload_form", locals: { game: }) }
        else
          format.turbo_stream { render turbo_stream: turbo_stream.replace("tab-2", partial: "input_form", locals: { game:, from_view: false }) }
        end
        format.html { redirect_to root_path, alert: game.errors.full_messages }
      end
    end
  end

  def file_upload?
    params[:file].present?
  end

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
end
