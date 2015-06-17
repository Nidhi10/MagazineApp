class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :commentable_id
      t.string :commentable_type
      t.references :user, index: true, foreign_key: true

      t.index [:commentable_id, :commentable_type]

      t.timestamps null: false

    end
  end
end
