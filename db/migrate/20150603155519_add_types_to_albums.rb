class AddTypesToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :types, :string, array: true, default: []
  end
end
