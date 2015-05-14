class RemoveSessionTokenDefault < ActiveRecord::Migration
  def change
    change_column_default :users, :session_token, nil
  end
end
