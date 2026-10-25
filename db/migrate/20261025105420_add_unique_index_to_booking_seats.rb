class AddUniqueIndexToBookingSeats < ActiveRecord::Migration[8.1]
  def change
    add_index :booking_seats,
              [:booking_id, :show_id, :seat_id],
              unique: true
  end
end