class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :book_title
      t.text :book_impressions

      t.timestamps
    end
  end
end
