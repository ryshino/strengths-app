class CreateEpisodes < ActiveRecord::Migration[7.0]
  def change
    create_table :episodes do |t|
      t.text :content, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :episodes, [:user_id, :created_at]
  end
end
