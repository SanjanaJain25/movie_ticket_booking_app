class Booking < ApplicationRecord
  belongs_to :user
  has_many :booking_seats, dependent: :restrict_with_error
  has_many :seat_reservations, dependent: :restrict_with_error

  validates :status, presence: true, inclusion: { in: %w[pending confirmed cancelled], message: "%{value} is not a valid status" }
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def cancel!
    return if status == "cancelled"

    transaction do
      seat_reservations.destroy_all
      update!(status: "cancelled")
    end
  end

end
