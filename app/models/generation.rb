class Generation < ApplicationRecord
  include MatrixParseable
  include GameRules
  include NeighborCountable

  belongs_to :game

  validates :counter, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :columns, :rows, numericality: { only_integer: true, greater_than_or_equal_to: 2 }
  validates :matrix, presence: true, matrix: true

  default_scope { order(counter: :asc) }

  def next_generation
    new_matrix = Array.new(rows) { Array.new(columns) }

    rows.times do |y|
      columns.times do |x|
        alive_neighbors = count_alive_neighbors(x, y)
        new_matrix[y][x] = calculate_next_state(alive?(x, y), alive_neighbors)
      end
    end

    new_matrix.map(&:join).join("\n")
  end

  def find_or_create_next_generation
    return self if matrix == next_generation

    next_counter = counter + 1

    Generation.find_or_create_by(game_id: game_id, counter: next_counter) do |generation|
      generation.rows = rows
      generation.columns = columns
      generation.matrix = next_generation
    end
  end
end
