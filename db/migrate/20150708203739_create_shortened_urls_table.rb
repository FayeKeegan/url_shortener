class CreateShortenedUrlsTable < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.text :short_url
      t.text :long_url
      t.integer :submitter_id
      t.timestamps
    end
  end
end
