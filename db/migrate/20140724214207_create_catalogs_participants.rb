class CreateCatalogsParticipants < ActiveRecord::Migration
  def change
    create_table :catalogs_participants do |t|
      t.integer :course_id
      t.string :name
      t.string :surnames
      t.string :mail
      t.string :phone_numbers
      t.string :workplace
      t.string :bachelor_deg
      t.string :master_deg
      t.string :phd_deg
      t.string :inv_name
      t.string :inv_rfc
      t.string :inv_address
      t.string :inv_city
      t.string :inv_municipality
      t.string :inv_state
      t.string :inv_email
      t.text :opt_text
      t.string :str_op1
      t.string :opt_str1
      t.string :opt_str2
      t.boolean :opt_bol1
      t.boolean :opt_bol2
      t.string :opt_sel
      t.boolean :confirmed
      t.integer :price, default: 1

      t.timestamps
    end
  end
end
