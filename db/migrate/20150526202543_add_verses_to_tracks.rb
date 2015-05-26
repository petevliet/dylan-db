class AddVersesToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :verses, :text, array: true, default: []
  end
end
