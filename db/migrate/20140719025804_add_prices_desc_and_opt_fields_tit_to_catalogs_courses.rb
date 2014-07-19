class AddPricesDescAndOptFieldsTitToCatalogsCourses < ActiveRecord::Migration
  def change
    add_column :catalogs_courses, :price1_desc, :string
    add_column :catalogs_courses, :price2_desc, :string
    add_column :catalogs_courses, :price3_desc, :string
    add_column :catalogs_courses, :opt_text, :string
    add_column :catalogs_courses, :opt_str1, :string
    add_column :catalogs_courses, :opt_str2, :string
    add_column :catalogs_courses, :opt_bol1, :string
    add_column :catalogs_courses, :opt_bol2, :string
    add_column :catalogs_courses, :opt_sel, :string
    add_column :catalogs_courses, :opt_sel_options, :string
  end
end
