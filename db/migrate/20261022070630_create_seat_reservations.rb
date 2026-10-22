class CreateSeatReservations < ActiveRecord::Migration[8.1]
  def change
    create_table :seat_reservations do |t|
      t.references :show, null: false, foreign_key: true
      t.references :seat, null: false, foreign_key: true
      t.references :booking, null: false, foreign_key: true

      t.timestamps
    end
  end
end
