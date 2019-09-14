class CreateTowns < ActiveRecord::Migration[5.1]
  def change
    create_table :towns do |t|
      t.integer :region_code
      t.string :region_name
      t.integer :dept_code
      t.integer :distr_code
      t.integer :code
      t.string :name
      t.integer :population
      t.float :average_age

      t.timestamps
    end
  end
end
