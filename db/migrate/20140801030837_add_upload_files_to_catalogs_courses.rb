class AddUploadFilesToCatalogsCourses < ActiveRecord::Migration
  def change
    add_column :catalogs_courses, :upload_files, :integer
  end
end
