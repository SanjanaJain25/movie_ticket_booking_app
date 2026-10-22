class CreateBookingSeats < ActiveRecord::Migration[8.1]
  def change
    create_table :booking_seats do |t|
      t.references :booking, null: false, foreign_key: true
      t.references :show, null: false, foreign_key: true
      t.references :seat, null: false, foreign_key: true
      t.decimal :ticket_price

      t.timestamps
    end
  end
end
