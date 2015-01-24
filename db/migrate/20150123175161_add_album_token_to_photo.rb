class AddAlbumTokenToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :album_token, :string
  end
end
