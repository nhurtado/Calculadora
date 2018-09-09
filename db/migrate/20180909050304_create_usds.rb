class CreateUsds < ActiveRecord::Migration[5.0]
  def change
    create_table :usds do |t|
      t.date :date_v
      t.float :value

      t.timestamps
    end
    add_index :usds, :date_v, unique: true
  end
end
