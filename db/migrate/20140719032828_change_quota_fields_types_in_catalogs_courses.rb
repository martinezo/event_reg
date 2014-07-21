class ChangeQuotaFieldsTypesInCatalogsCourses < ActiveRecord::Migration
  def change
    change_column :catalogs_courses, :min_quota, :integer
    change_column :catalogs_courses, :max_quota, :integer
  end
end
