class CreateGolds < ActiveRecord::Migration[5.0]
  def change
    create_table :golds do |t|
      t.date :date_v
      t.float :value

      t.timestamps
    end
    add_index :golds, :date_v, unique: true
  end
end
