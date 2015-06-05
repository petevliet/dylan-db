class AddAlbumReviewToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :album_review, :text
  end
end
