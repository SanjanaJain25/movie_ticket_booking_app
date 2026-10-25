class MakeCreatedByRequiredOnMovies < ActiveRecord::Migration[8.1]
  def change
    change_column_null :movies, :created_by_id, false
  end
end