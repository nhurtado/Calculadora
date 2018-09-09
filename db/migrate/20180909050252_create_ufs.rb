class CreateUfs < ActiveRecord::Migration[5.0]
  def change
    create_table :ufs do |t|
      t.date :date_v
      t.float :value

      t.timestamps
    end
    add_index :ufs, :date_v, unique: true
  end
end
