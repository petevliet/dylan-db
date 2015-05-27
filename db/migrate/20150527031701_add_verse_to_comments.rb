class AddVerseToComments < ActiveRecord::Migration
  def change
    add_column :comments, :verse, :integer
  end
end
