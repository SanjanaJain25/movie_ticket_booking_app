class CreateShows < ActiveRecord::Migration[8.1]
  def change
    create_table :shows do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :screen, null: false, foreign_key: true
      t.datetime :starts_at
      t.datetime :ends_at
      t.decimal :ticket_price

      t.timestamps
    end
  end
end
