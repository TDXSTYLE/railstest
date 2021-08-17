class CreateVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :videos do |t|
      t.string :name
      t.string :description
      t.string :video_source_id
      t.string :slug

      t.timestamps
    end
    add_index :videos, :slug, unique: true
  end
end
