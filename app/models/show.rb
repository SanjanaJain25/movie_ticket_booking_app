class Show < ApplicationRecord
  belongs_to :movie
  belongs_to :screen

  has_many :booking_seats, dependent: :restrict_with_error
  has_many :seat_reservations, dependent: :restrict_with_error

  validates :ticket_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :ends_after_starts 

  private 
  def ends_after_starts
    return if ends_at.blank? || starts_at.blank?

    if ends_at <= starts_at
      errors.add(:ends_at, "must be after the start time")
    end
  end
end
