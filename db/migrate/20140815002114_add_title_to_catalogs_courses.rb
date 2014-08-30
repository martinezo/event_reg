class AddTitleToCatalogsCourses < ActiveRecord::Migration
  def change
    add_column :catalogs_courses, :title, :string, default: ''
  end
end
