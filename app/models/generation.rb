class Generation < ApplicationRecord
  belongs_to :game

  validates :counter, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :columns, :rows, numericality: { only_integer: true, greater_than_or_equal_to: 2 }
  validates :matrix, presence: true, matrix: true

  before_validation :normalize_fields

  scope :ordered, -> { order(counter: :asc) }

  def next_generation
    generator = MatrixGenerator.new(matrix_array, rows, columns)
    generator.generate
  end

  def find_or_create_next_generation
    next_matrix = next_generation
    return self if matrix == next_matrix

    next_counter = counter + 1

    Generation.find_or_create_by(game_id: game_id, counter: next_counter) do |generation|
      generation.rows = rows
      generation.columns = columns
      generation.matrix = next_matrix
    end
  end

  def matrix_array
    matrix.split.map { |row| row.chars.compact_blank }
  end

  private

  def normalize_fields
    self.matrix = matrix.try(:strip)
  end
end
