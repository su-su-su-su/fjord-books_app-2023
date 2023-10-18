class CreateMentions < ActiveRecord::Migration[7.0]
  def change
    create_table :mentions do |t|
      t.integer :mentioning_report_id, null: false
      t.integer :mentioned_report_id, null: false

      t.timestamps
    end

    add_index :mentions, [:mentioning_report_id, :mentioned_report_id], unique: true
  end
end
