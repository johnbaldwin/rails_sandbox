class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|

      t.timestamps
    end
    add_attachment :uploads, :uploaded_file
  end
end
