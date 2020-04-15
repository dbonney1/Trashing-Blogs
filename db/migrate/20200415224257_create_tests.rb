class CreateTests < ActiveRecord::Migration[5.2]
  def change
    create_table :tests do |t|
      t.string :title
      t.text :text
      t.string :tag
      t.string :test123

      t.timestamps
    end
  end
end
