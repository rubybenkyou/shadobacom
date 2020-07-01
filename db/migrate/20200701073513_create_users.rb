class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :register_id,null: false
      t.string :password_digest
      t.string :name,null: false

      t.timestamps
    end
    add_index :users,:register_id,unique: true
  end
end
