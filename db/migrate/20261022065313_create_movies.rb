class CreateMovies < ActiveRecord::Migration[8.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :genre
      t.string :language
      t.integer :duration
      t.date :release_date

      t.timestamps
    end
  end
end
