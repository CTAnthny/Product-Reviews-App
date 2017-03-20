class AddWebsiteToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :website, :string
  end
end
