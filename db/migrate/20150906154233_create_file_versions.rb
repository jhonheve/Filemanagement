class CreateFileVersions < ActiveRecord::Migration
  def change
    create_table :file_versions do |t|
      t.string :path
      t.references :versioned_file, index: true, foreign_key: true
      t.boolean :isActive

      t.timestamps null: false
    end
  end
end
