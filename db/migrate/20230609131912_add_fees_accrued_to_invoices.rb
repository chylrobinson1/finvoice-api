class AddFeesAccruedToInvoices < ActiveRecord::Migration[7.0]
  def change
    add_column :invoices, :fees_accrued, :decimal
  end
end
