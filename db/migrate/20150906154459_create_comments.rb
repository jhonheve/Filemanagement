class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :description
      t.references :file_version, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
