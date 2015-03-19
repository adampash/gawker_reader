class AddSiteOwnerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :site_owner, :boolean, default: false
  end
end
