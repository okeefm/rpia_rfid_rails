class AddRfidStuffToUser < ActiveRecord::Migration
  def change
    add_column :users, :facility_code, :string
    add_column :users, :id_code, :string
  end
end
