class AddModelNameToVehiclesTable < ActiveRecord::Migration
  def change
    add_column :vehicles, :model_name, :string
    ActiveRecord::Base.connection.execute("update vehicles set vehicles.model_name=vehicles.model")
  end
end
