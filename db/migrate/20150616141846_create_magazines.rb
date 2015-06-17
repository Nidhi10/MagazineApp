class CreateMagazines < ActiveRecord::Migration
  def change
    create_table :magazines do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
