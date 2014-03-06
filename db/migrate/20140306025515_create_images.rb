class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.string :signature
      t.boolean :status

      t.timestamps
    end
    add_attachment :images, :image
  end
end
