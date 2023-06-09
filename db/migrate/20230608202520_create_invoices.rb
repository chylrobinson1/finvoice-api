class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.string :number
      t.decimal :amount
      t.date :due_date
      t.integer :status
      t.string :scan
      t.references :borrower, null: false, foreign_key: true

      t.timestamps
    end
  end
end
