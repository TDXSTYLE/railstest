class AddPaymentFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :stripe_id, :string
    add_column :users, :card_brand, :string
    add_column :users, :card_exp_month, :integer
    add_column :users, :card_exp_year, :integer
    add_column :users, :card_last4, :string
  end
end
