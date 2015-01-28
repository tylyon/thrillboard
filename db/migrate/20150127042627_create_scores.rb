class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.decimal :current_scoring, default: 0.00, null: false
      t.decimal :highest_scoring, default: 0.00, null: false

      t.timestamps null: false
    end
  end
end
