class AddAgeToUser < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :age, :string
  end
end
