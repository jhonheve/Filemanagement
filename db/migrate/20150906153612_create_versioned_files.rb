class CreateVersionedFiles < ActiveRecord::Migration
  def change
    create_table :versioned_files do |t|
      t.string :name
      t.string :content_type
      t.text :description

      t.timestamps null: false
    end
  end
end
