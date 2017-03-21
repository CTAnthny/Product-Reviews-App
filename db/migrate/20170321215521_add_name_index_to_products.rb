class AddNameIndexToProducts < ActiveRecord::Migration[5.0]
  def change
    add_index :products, :name, unique: true
  end
end
