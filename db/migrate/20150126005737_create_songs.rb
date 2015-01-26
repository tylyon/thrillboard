class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name, null: false
      t.integer :artist_id
      t.integer :album_id
      t.string :sc_url, null: false
      t.decimal :index, default: 0.00, null: false
      t.integer :genre_id

      t.timestamps null: false
    end
  end
end
