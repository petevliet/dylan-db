class RemoveDurationFromTracks < ActiveRecord::Migration
  def change
    remove_column :tracks, :duration, :integer
  end
end
