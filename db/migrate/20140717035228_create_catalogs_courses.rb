class CreateCatalogsCourses < ActiveRecord::Migration
  def change
    create_table :catalogs_courses do |t|
      t.integer :user_id
      t.string :name
      t.string :description
      t.string :schedule
      t.string :location
      t.string :content_file
      t.decimal :price1
      t.decimal :price2
      t.decimal :price3
      t.string :payment_methods
      t.string :target
      t.string :prerequisites
      t.integer :min_quota
      t.integer :max_quota
      t.string :instructors
      t.string :contact
      t.string :image_file1
      t.string :image_file2
      t.string :image_file3
      t.date :start_date_pub
      t.date :end_date_pub
      t.date :start_date_reg
      t.date :end_date_reg
      t.string :mail_notif_deposit
      t.boolean :academic_data_required
      t.string :info_after_reg
      t.string :color_theme1
      t.string :color_theme2
      t.string :color_theme3
      t.string :opt_field
      t.string :opt_field_title

      t.timestamps
    end
  end
end
