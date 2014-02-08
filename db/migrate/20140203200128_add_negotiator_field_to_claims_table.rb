class AddNegotiatorFieldToClaimsTable < ActiveRecord::Migration
  def change
    change_table :claims do |t|
      t.string :negotiator, null: false
    end
    ActiveRecord::Base.connection.execute("update claims set negotiator=if(is_acd_negotiation=1,'acd','client');")
    remove_column :claims, :is_acd_negotiation
  end
end
