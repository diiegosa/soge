class CreateCommandPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :command_posts do |t|
      t.string :description
      t.string :acronym

      t.timestamps
    end
  end
end
