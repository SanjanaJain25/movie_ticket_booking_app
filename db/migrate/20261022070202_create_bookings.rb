class CreateBookings < ActiveRecord::Migration[8.1]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status
      t.decimal :total_amount

      t.timestamps
    end
  end
end
