class AddFieldsToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :tag, :string
  end
end
