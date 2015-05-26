class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :track_id
      t.text :annotation
      t.datetime :created_at
    end
  end
end
