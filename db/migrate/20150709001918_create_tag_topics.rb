class CreateTagTopics < ActiveRecord::Migration
  def change
    create_table :tag_topics do |t|
      t.text :topic
      t.timestamps null: false
    end
  end
end
