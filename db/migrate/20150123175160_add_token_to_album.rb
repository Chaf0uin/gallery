class AddTokenToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :token, :string
  end
end
