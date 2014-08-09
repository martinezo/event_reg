class AddStateIdToCatalogsParticipant < ActiveRecord::Migration
  def change
    remove_columns :catalogs_participants, :inv_state
    add_column :catalogs_participants, :inv_state_id, :integer, default: 22
  end
end
