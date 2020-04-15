class CreateAbuseReports < ActiveRecord::Migration[5.2]
  def change
    create_table :abuse_reports do |t|
      t.string :reason
      t.text :body
      t.references :article, foreign_key: true

      t.timestamps
    end
  end
end
