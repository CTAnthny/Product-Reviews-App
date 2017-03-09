class AddProductRefToComments < ActiveRecord::Migration[5.0]
  def change
    add_reference :comments, :product, index: true, foreign_key: true
  end
end
