class AddSiteAndStoryDateColumnsToComments < ActiveRecord::Migration
  def change
    add_column :comments, :site, :string
    add_column :comments, :story_date, :datetime
  end
end
