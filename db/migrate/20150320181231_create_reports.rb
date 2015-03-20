class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :user_id
      t.string :name
      t.string :domain
      t.text :summary
      t.boolean :published, default: false

      t.timestamps null: false
    end
  end
end
