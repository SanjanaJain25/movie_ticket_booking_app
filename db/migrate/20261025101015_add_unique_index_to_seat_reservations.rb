class AddUniqueIndexToSeatReservations < ActiveRecord::Migration[8.1]
  def change
    add_index :seat_reservations, [:show_id, :seat_id], unique: true
  end
end