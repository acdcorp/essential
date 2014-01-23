class AddRequiredFieldsToUsersTable < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :first_name, :last_name, :business_phone,
        :business_phone_ext, :cell_phone, after: :id

      t.references :creator, :updater, :role, :company, null: false

      t.timestamps
    end
  end
end
