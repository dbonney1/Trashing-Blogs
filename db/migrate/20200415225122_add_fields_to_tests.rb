class AddFieldsToTests < ActiveRecord::Migration[5.2]
  def change
    add_column :tests, :foo, :string
    add_column :tests, :bag, :string
  end
end
