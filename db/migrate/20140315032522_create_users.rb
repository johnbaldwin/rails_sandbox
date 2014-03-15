class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      # NOTE: If you are going to use Devise, then don't create an email attribute
      #t.string :email
      t.datetime :joined

      t.timestamps
    end
  end
end
