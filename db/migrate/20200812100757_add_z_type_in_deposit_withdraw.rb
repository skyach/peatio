class AddZTypeInDepositWithdraw < ActiveRecord::Migration[5.2]
  def up
    add_column :deposits, :z_type, :integer, after: :type unless column_exists?(:deposits, :z_type)
    add_column :withdraws, :z_type, :integer, after: :type unless column_exists?(:withdraws, :z_type)
  end

  def down
    remove_column :deposits, :z_type if column_exists?(:deposits, :z_type)
    remove_column :withdraws, :z_type if column_exists?(:withdraws, :z_type)
  end
end
