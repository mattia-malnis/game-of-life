module NeighborCountable
  extend ActiveSupport::Concern

  private

  def count_alive_neighbors(x, y)
    count = 0

    ((y - 1)..(y + 1)).each do |next_y|
      next if next_y < 0 || next_y >= rows

      ((x - 1)..(x + 1)).each do |next_x|
        next if next_x < 0 || next_x >= columns
        next if next_x == x && next_y == y

        count += 1 if matrix_array[next_y][next_x] == GameRules::ALIVE
      end
    end

    count
  end
end
