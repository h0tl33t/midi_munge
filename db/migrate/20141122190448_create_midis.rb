class CreateMidis < ActiveRecord::Migration
  def change
    create_table :midis do |t|
      t.string :name,         null: false
      t.string :file_uid,     null: false
      t.string :file_name,    null: false
      t.json   :munged_format

      t.timestamps
    end

    add_index :midis, :name, unique: true
  end
end
