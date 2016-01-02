class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :firstName
      t.string :lastName
      t.string :email
      t.integer :sign_in_count, default: 0, null: false
      t.timestamps null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :username, unique:true


  end
end
