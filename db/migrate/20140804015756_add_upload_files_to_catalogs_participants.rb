class AddUploadFilesToCatalogsParticipants < ActiveRecord::Migration
  def change
    add_column :catalogs_participants, :upload_file1, :string
    add_column :catalogs_participants, :upload_file2, :string
    add_column :catalogs_participants, :upload_file3, :string
  end
end
