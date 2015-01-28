class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :name
      t.decimal :rank_weight, default: 0.10, null: false
      t.integer :alexa_rank
      t.string :url, null: false

      t.timestamps null: false
    end
  end
end
