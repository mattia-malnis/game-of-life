class MatrixGenerator
  ALIVE = "*".freeze
  DEAD = ".".freeze

  def initialize(matrix, rows, columns)
    @matrix = matrix
    @rows = rows
    @columns = columns
  end

  def generate
    new_matrix = Array.new(@rows) { Array.new(@columns, DEAD) }

    @rows.times do |y|
      @columns.times do |x|
        new_matrix[y][x] = ALIVE if should_be_alive?(x, y)
      end
    end

    new_matrix.map(&:join).join("\n")
  end

  private

  def should_be_alive?(x, y)
    alive_neighbors = count_alive_neighbors(x, y)
    is_next_state_alive?(alive?(x, y), alive_neighbors)
  end

  def is_next_state_alive?(current_alive, alive_neighbors)
    if current_alive
      [2, 3].include?(alive_neighbors)
    else
      alive_neighbors == 3
    end
  end

  def count_alive_neighbors(x, y)
    count = 0

    ((y - 1)..(y + 1)).each do |next_y|
      next if next_y < 0 || next_y >= @rows

      ((x - 1)..(x + 1)).each do |next_x|
        next if next_x < 0 || next_x >= @columns
        next if next_x == x && next_y == y

        count += 1 if @matrix[next_y][next_x] == ALIVE
      end
    end

    count
  end

  def alive?(x, y)
    @matrix[y][x] == ALIVE
  end
end
