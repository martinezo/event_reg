class ChangePriceNameAndAddPriceToCatalogsParticipants < ActiveRecord::Migration
  def change
    rename_column :catalogs_participants, :price, :price_id
    add_column :catalogs_participants, :price, :decimal, :default => 0
  end
end
