class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :bio
      t.string :imageurl
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
