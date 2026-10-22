class Seat < ApplicationRecord
  belongs_to :screen
  has_many :booking_seats, dependent: :restrict_with_error
  has_many :seat_reservations, dependent: :restrict_with_error

  validates :row_label, presence: true, format: { with: /\A[A-Z]\z/, message: "must be a single uppercase letter" }
  validates :seat_number, presence: true, numericality: { only_integer: true, greater_than: 0 }, uniqueness: { scope: [:screen_id, :row_label], message: "must be unique within the same screen" }
end
