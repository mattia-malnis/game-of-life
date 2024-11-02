class UserSession < ApplicationRecord
  has_many :games, dependent: :destroy
end
