class Borrower < ApplicationRecord
  has_many :invoices
end
