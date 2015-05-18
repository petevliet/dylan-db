class AddAlbumIdToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :album_id, :string
  end
end
