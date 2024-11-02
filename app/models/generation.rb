class Generation < ApplicationRecord
  belongs_to :game

  validates :counter, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :columns, :rows, numericality: { only_integer: true, greater_than_or_equal_to: 2 }
  validates :matrix, presence: true, matrix: true
end
