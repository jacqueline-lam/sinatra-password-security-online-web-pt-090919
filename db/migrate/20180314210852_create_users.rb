class CreateUsers < ActiveRecord::Migration[5.1]
  def up
    create_table :users do |t|
      t.string :username
      # where BCrypt store salted, hashed version of our users' passwords in db
      t.string :password_digest
    end
  end
 
  def down
    drop_table :users
  end
end