class Show < ApplicationRecord
    include AdminCreatedRecord

  belongs_to :movie
  belongs_to :screen

  has_many :booking_seats, dependent: :restrict_with_error
  has_many :seat_reservations, dependent: :restrict_with_error

  validates :ticket_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :ends_after_starts
  validate :no_overlapping_shows
 
  def available_seats
  reserved_seat_ids = seat_reservations.pluck(:seat_id)

  screen.seats.where.not(id: reserved_seat_ids)
  end

  private

  def ends_after_starts
    return if ends_at.blank? || starts_at.blank?

    if ends_at <= starts_at
      errors.add(:ends_at, "must be after the start time")
    end
  end

  def no_overlapping_shows
    return if screen_id.blank? || starts_at.blank? || ends_at.blank?
    return if ends_at <= starts_at

    overlapping_shows = Show.where(screen_id: screen_id)
                             .where("starts_at < ? AND ends_at > ?",
                                    ends_at, starts_at)

    overlapping_shows = overlapping_shows.where.not(id: id) if persisted?

    if overlapping_shows.exists?
      errors.add(:base, "Another show is already scheduled on this screen during this time")
    end
  end
end
