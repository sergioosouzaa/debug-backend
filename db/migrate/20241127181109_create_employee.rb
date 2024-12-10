class CreateEmployee < ActiveRecord::Migration[7.2]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :email
      t.integer :age

      t.timestamps
    end
  end
end
