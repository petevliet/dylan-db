class AddLargeImageUrlToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :large_image_url, :string
  end
end
