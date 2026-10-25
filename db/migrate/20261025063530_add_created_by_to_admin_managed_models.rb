class AddCreatedByToAdminManagedModels < ActiveRecord::Migration[8.1]
  def change
    [:cinemas, :screens, :seats, :shows].each do |table|
      add_reference table, :created_by,
                    foreign_key: { to_table: :users },
                    index: true
    end
  end
end