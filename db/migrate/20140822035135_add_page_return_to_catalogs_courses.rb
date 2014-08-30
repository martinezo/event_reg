class AddPageReturnToCatalogsCourses < ActiveRecord::Migration
  def change
    add_column :catalogs_courses, :return_page, :string, default: ''
  end
end
