# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# Create some borrowers
borrowers = [
  { name: 'Borrower 1' },
  { name: 'Borrower 2' },
  { name: 'Borrower 3' },
]

borrowers.each do |borrower|
  Borrower.create!(borrower)
end

invoices = [
  { number: 'INV00001', borrower: Borrower.first, amount: 1000.0, due_date: Date.today + 30, status: "created", fees_accrued: 11.23 },
  { number: 'INV00002', borrower: Borrower.first, amount: 2000.0, due_date: Date.today + 60, status: "created", fees_accrued: 25 },
  { number: 'INV00003', borrower: Borrower.second, amount: 1500.0, due_date: Date.today + 45, status: "created", fees_accrued: 10 },
  { number: 'INV00004', borrower: Borrower.last, amount: 1500.0, due_date: Date.today + 45, status: "created", fees_accrued: 10 },
]

invoices.each do |invoice|
  Invoice.create!(invoice)
end