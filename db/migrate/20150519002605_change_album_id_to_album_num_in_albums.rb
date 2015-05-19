class ChangeAlbumIdToAlbumNumInAlbums < ActiveRecord::Migration
  def change
    remove_column :albums, :album_id, :string
    add_column :albums, :album_num, :string
  end
end
