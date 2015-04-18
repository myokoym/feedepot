class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :link
      t.string :title
      t.text :description
      t.datetime :date
      t.references :resource, index: true

      t.timestamps null: false
    end
    add_foreign_key :feeds, :resources
  end
end
