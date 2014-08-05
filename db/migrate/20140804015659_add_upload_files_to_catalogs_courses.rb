class AddUploadFilesToCatalogsCourses < ActiveRecord::Migration
  def change
    add_column :catalogs_courses, :content_file_desc, :string
    add_column :catalogs_courses, :upload_file1_desc, :string
    add_column :catalogs_courses, :upload_file2_desc, :string
    add_column :catalogs_courses, :upload_file3_desc, :string
  end
end
