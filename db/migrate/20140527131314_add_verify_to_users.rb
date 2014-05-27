class AddVerifyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :token, :string
    add_column :users, :verify, :boolean, default: 0
  end
end
