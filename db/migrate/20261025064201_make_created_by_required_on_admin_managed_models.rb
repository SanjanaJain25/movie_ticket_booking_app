class MakeCreatedByRequiredOnAdminManagedModels < ActiveRecord::Migration[8.1]
  def change
    change_column_null :movies, :created_by_id, false
    change_column_null :cinemas, :created_by_id, false
    change_column_null :screens, :created_by_id, false
    change_column_null :seats, :created_by_id, false
    change_column_null :shows, :created_by_id, false
  end
end