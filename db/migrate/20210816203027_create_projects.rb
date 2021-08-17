class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.string :web_link
      t.string :github_link
      t.string :slug, null: false
      t.timestamps
    end
  end
end
