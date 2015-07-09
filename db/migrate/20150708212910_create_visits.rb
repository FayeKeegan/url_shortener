class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :shortened_url_id
      t.integer :visitor_id

      t.timestamps null: false
    end
  end
end
