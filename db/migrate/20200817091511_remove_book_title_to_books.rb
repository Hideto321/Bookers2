class RemoveBookTitleToBooks < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :book_title, :string
    remove_column :books, :book_impressions, :text

  end
end
