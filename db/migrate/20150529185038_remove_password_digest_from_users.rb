class RemovePasswordDigestFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :password_digest, :string
    remove_column :users, :email, :string
    add_column :users, :name, :string
    add_column :users, :nickname, :string
  end
end
