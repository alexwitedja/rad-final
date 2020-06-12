class Add < ActiveRecord::Migration[5.2]
  def change
    add_column :cities, :country, :string
    add_column :cities, :name, :string
  end
end
