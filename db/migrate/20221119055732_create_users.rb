class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false 
      t.string :profile, null: false

      t.timestamps
      t.index :profile, unique: true
    end
  end
end
