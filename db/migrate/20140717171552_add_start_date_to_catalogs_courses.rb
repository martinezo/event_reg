class AddStartDateToCatalogsCourses < ActiveRecord::Migration
  def change
    add_column :catalogs_courses, :start_date, :date
  end
end
