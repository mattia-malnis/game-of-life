class Game < ApplicationRecord
  belongs_to :user_session
  has_many :generations, dependent: :destroy

  accepts_nested_attributes_for :generations
end
