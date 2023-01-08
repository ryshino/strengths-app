class AddTitleToEpisodes < ActiveRecord::Migration[7.0]
  def change
    add_column :episodes, :title, :string
  end
end
