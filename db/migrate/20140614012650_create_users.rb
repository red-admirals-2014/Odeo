class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :access_token
      t.string :refresh_token
      t.string :expires_in
      t.string :scope
    end
  end
end
