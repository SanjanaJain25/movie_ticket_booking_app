class BookingSeat < ApplicationRecord
  belongs_to :booking
  belongs_to :show
  belongs_to :seat

  validates :ticket_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
