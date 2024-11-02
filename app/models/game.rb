class Game < ApplicationRecord
  belongs_to :user_session
  has_many :generations, dependent: :destroy
end
