class CreateDateValues < ActiveRecord::Migration[5.0]
  def change
    create_table :date_values do |t|
      t.date :date_v
      t.float :uf
      t.float :usd
      t.float :gold

      t.timestamps
    end
    add_index :date_values, :date_v, unique: true
  end
end
