class CreateTagRelations < ActiveRecord::Migration[7.0]
  def change
    create_table :tag_relations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :episode, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
    add_index :tag_relations, [:user_id, :episode_id, :tag_id], unique: true
  end
end
