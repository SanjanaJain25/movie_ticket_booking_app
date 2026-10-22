class CreateCinemaReviews < ActiveRecord::Migration[8.1]
  def change
    create_table :cinema_reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :cinema, null: false, foreign_key: true
      t.integer :rating
      t.text :feedback

      t.timestamps
    end
  end
end
