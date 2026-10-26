class Booking < ApplicationRecord
  belongs_to :user
  has_many :booking_seats, dependent: :restrict_with_error
  has_many :seat_reservations, dependent: :restrict_with_error

  has_many :shows, through: :booking_seats
  has_many :seats, through: :booking_seats

  validates :status, presence: true, inclusion: { in: %w[pending confirmed cancelled], message: "%{value} is not a valid status" }
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def cancel!
    return if status == "cancelled"

    
 transaction do
      seat_reservations.destroy_all
      update!(status: "cancelled")
    end
  end

 def details
  {
    booking_id: id,
    status: status,
    total_amount: total_amount.to_f,
    movie: shows.first&.movie&.title,
    cinema: shows.first&.screen&.cinema&.name,
    show_starts_at: shows.first&.starts_at,
    show_ends_at: shows.first&.ends_at,
    seats: seats.map { |seat| "#{seat.row_label}#{seat.seat_number}" }
  }
end


def self.book_seats!(user:, show:, seat_ids:)
  seat_ids = Array(seat_ids).map(&:to_i).uniq

  raise ArgumentError, "Select at least one seat" if seat_ids.empty?
  raise ArgumentError, "Show is not available" if show.nil?
  raise ArgumentError, "Show has already ended" if show.ends_at <= Time.current

  seats = Seat.where(id: seat_ids)

  unless seats.count == seat_ids.size
    raise ArgumentError, "One or more selected seats do not exist"
  end

  unless seats.all? { |seat| seat.screen_id == show.screen_id }
    raise ArgumentError, "Selected seats must belong to this show's screen"
  end

  transaction do
    reserved_ids = SeatReservation
      .where(show_id: show.id, seat_id: seat_ids)
      .lock
      .pluck(:seat_id)

    if reserved_ids.any?
      raise ArgumentError, "One or more seats are already reserved"
    end

    booking = create!(
      user: user,
      status: "confirmed",
      total_amount: show.ticket_price * seat_ids.size
    )

    seat_ids.each do |seat_id|
      BookingSeat.create!(
        booking: booking,
        show: show,
        seat_id: seat_id,
        ticket_price: show.ticket_price
      )

      SeatReservation.create!(
        booking: booking,
        show: show,
        seat_id: seat_id
      )
    end

    booking
  end
end
end

