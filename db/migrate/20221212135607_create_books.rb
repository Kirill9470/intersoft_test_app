class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :name, null: false
      t.date :date, null: false
      t.string :author, null: false
      t.timestamps
    end

    add_index :books, [:author, :name], unique: true
  end
end
