class SeatReservation < ApplicationRecord
  belongs_to :show
  belongs_to :seat
  belongs_to :booking

  validates :seat_id, uniqueness: { scope: :show_id, message: "is already reserved for this show" }
end
