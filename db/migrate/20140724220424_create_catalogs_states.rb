class CreateCatalogsStates < ActiveRecord::Migration
  def change
    create_table :catalogs_states do |t|
      t.string :name

      t.timestamps
    end
  end
end
