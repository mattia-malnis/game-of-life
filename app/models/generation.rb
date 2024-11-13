class Generation < ApplicationRecord
  belongs_to :game

  validates :counter, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :columns, :rows, numericality: { only_integer: true, greater_than_or_equal_to: 2 }
  validates :matrix, presence: true, matrix: true

  before_validation :normalize_fields
  before_save :generate_matrix_hash

  scope :ordered, -> { order(counter: :asc) }

  def next_generation
    generator = MatrixGenerator.new(matrix_array, rows, columns)
    generator.generate
  end

  def find_or_create_next_generation
    next_counter = counter + 1
    existing_generation = Generation.find_by(game_id: game_id, counter: next_counter)
    return existing_generation if existing_generation.present?

    next_matrix = next_generation
    return self if matrix == next_matrix

    existing_generation = Generation.find_by(game_id: game_id, matrix_hash: self.class.to_hash(next_matrix))
    return existing_generation if existing_generation.present?

    Generation.create({
      game_id: game_id,
      counter: next_counter,
      rows: rows,
      columns: columns,
      matrix: next_matrix
    })
  end

  def matrix_array
    matrix.split.map { |row| row.chars.compact_blank }
  end

  def self.to_hash(value)
    return if value.blank?

    Digest::SHA256.hexdigest(value)
  end

  private

  def normalize_fields
    self.matrix = matrix.try(:strip)
  end

  def generate_matrix_hash
    return unless will_save_change_to_matrix?

    self.matrix_hash = self.class.to_hash(matrix)
  end
end
