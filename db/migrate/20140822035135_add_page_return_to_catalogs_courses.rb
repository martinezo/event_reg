class AddPageReturnToCatalogsCourses < ActiveRecord::Migration
  def change
    add_column :catalogs_courses, :page_return, :string
  end
end
