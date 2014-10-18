class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :address,  null: false, default: ""
      t.float :latitude,  null: false, default: ""
      t.float :longitude, null: false, default: ""
    end
  end
end
