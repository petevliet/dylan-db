class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :title
      t.integer :duration
      t.string :track_id
      t.belongs_to :album
    end
  end
end
