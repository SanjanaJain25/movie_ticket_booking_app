class CreateMovieReviews < ActiveRecord::Migration[8.1]
  def change
    create_table :movie_reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true
      t.integer :rating
      t.text :feedback

      t.timestamps
    end
  end
end
