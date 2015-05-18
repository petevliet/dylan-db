class CreateAlbum < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title
      t.datetime :release_date
      t.integer :tracks
    end
  end
end
