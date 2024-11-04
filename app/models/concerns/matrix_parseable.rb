module MatrixParseable
  extend ActiveSupport::Concern

  included do
    before_validation :normalize_fields
  end

  def matrix_array
    @matrix_array ||= matrix.split.map { |row| row.chars.compact_blank }
  end

  private

  def normalize_fields
    self.matrix = matrix.try(:strip)
  end
end
