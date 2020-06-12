class CreateClocks < ActiveRecord::Migration[5.2]
  def change
    create_table :clocks do |t|
      t.string :city
      t.timestamps
    end
  end
end
