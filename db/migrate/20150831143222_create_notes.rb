class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :text
      t.text :month_and_year
      t.text :site

      t.timestamps null: false
    end
  end
end
