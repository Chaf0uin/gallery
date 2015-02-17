class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :commenter
      t.datetime :creation_date
      t.text :body
      t.references :photo, index: true

      t.timestamps
    end
  end
end
