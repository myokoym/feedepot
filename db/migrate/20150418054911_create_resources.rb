class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.text :text
      t.string :is_comment
      t.string :is_breakpoint
      t.string :created
      t.string :category
      t.text :description
      t.string :url
      t.string :html_url
      t.string :xml_url, null: false
      t.string :title
      t.string :version
      t.string :language

      t.timestamps null: false
    end
  end
end
