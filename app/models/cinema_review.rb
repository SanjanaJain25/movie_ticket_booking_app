class CinemaReview < ApplicationRecord
  belongs_to :user
  belongs_to :cinema

  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :feedback, presence: true, length: { maximum: 500 }
end
