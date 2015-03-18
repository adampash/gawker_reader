class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :author, null: false
      t.integer :kinja_id, null: false
      t.text :text, null: false
      t.text :headline, null: false
      t.string :unique_hash, null: false
      t.string :url, null: false
      t.string :domain, null: false
      t.datetime :publish_time, null: false

      t.json :big_image
      t.json :small_image
      t.json :data

      t.timestamps null: false
    end
  end
end
