class AddSessionToken < ActiveRecord::Migration
  def change
    add_column :users, :session_token, :string, null: false, default: "session_token"
  end
end
