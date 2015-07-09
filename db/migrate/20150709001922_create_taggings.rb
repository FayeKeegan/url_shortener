class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :shortened_url_id
      t.integer :tag_topic_id
      t.timestamps null: false
    end
  end
end
