class CreateAddressesTable < ActiveRecord::Migration
  def change
  	create_table :addresses do |t|
  		t.string :address1
  		t.string :address2
  		t.string :city
  		t.string :state
  		t.string :zipcode
  		t.integer :userid
  	end
  end
end
