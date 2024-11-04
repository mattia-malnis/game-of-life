module GameRules
  extend ActiveSupport::Concern

  ALIVE = "*".freeze
  DEAD = ".".freeze

  private

  def calculate_next_state(current_alive, alive_neighbors)
    if current_alive
      [2, 3].include?(alive_neighbors) ? ALIVE : DEAD
    else
      alive_neighbors == 3 ? ALIVE : DEAD
    end
  end

  def alive?(x, y)
    matrix_array[y][x] == ALIVE
  end
end
