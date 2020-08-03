class CreateEventsCommandPostsJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :events, :command_posts
  end
end
