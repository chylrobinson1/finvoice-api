class AddDefaultStatusToInvoices < ActiveRecord::Migration[7.0]
  def change
    change_column_default :invoices, :status, from: nil, to: 0
  end
end
