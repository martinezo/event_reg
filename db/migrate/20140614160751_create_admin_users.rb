class CreateAdminUsers < ActiveRecord::Migration
  def change
    create_table :admin_users do |t|
      t.string :login
      t.string :name
      t.string :mail

      t.timestamps
    end
  end
end
